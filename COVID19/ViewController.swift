//
//  ViewController.swift
//  COVID19
//
//  Created by 이동희 on 2022/01/16.
//

import UIKit

import Alamofire
import Charts //for PieChartView

class ViewController: UIViewController {

    @IBOutlet var totalCaseLabel: UILabel!
    @IBOutlet var newCaseLabel: UILabel!
    @IBOutlet var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCovidOverview(completionHandler: { [weak self] result in //순환참조 방지 - weak self
            guard let self = self else { return } //일시적으로 self가 strong reference가 되도록 만듦
            switch result {
            case let .success(result):
                self.configureStackView(koreaCovieOverview: result.korea)
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
                self.configureChatView(covidOverviewList: covidOverviewList)
            case let .failure(error):
                debugPrint("Error \(error)")
            }
        })
    }
    
    //PieCharts 표시
    func makeCovidOverviewList(
        cityCovidOverview: CityCovidOverview
    ) -> [CovidOverView] {
        return [
            //JSON 응답이 배열이 아닌 하나의 객체로 오기 때문에 CityCovidOverview 객체안에 있는 시도별 객체를 배열에 추가
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju,
        ]
    }
    
    func configureChatView(covidOverviewList: [CovidOverView]) {
        //Piecharts 객체로 매핑시키는 코드 작성
        let entries = covidOverviewList.compactMap { [weak self] overview -> PieChartDataEntry? in
            guard let self = self else { return nil } //일시적으로 self가 String reference
        //PieCharts 데이터 객체 엔트리로 매핑하기 위해
            return PieChartDataEntry(
                value: self.removeFormatString(string: overview.newCase),
                label: overview.countryName,
                data: overview)
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1 //항목간 간격을 1로
        dataSet.entryLabelColor = .black
        dataSet.xValuePosition = .outsideSlice //항목 이름이 PieCharts 바깥선으로 표시되도록
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        
        //그래프 항목이 다양한 색상으로 표시되도록
        dataSet.colors = ChartColorTemplates.vordiplom() +
        ChartColorTemplates.joyful() +
        ChartColorTemplates.liberty() +
        ChartColorTemplates.pastel() +
        ChartColorTemplates.material() 
        
        self.pieChartView.data = PieChartData(dataSet: dataSet)
    }
    
    func removeFormatString(string: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0 //nil이면 0
    }
    
    func configureStackView(koreaCovieOverview: CovidOverView) {
        self.totalCaseLabel.text = "\(koreaCovieOverview.totalCase)명"
        self.newCaseLabel.text = "\(koreaCovieOverview.newCase)명"
    }
    
    //Alamofire를 이용해서 시도별 코로나 현황을 가져올 수 있는 API 호출
    func fetchCovidOverview(
        //escaping 클로저: 함수의 인자로 클로저가 전달되지만 함수가 반환된 후에도 실행되는 걸 의미
        //대표사례: 비동기 작업을 하는경우 completionHandler로 escaping closure 사용, 네트워크 통신 시 비동기로 작업
        completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void //요청 성공 시 CityCovidOverview 열거형 값을 전달받음
    ) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": "46CmusQG2ekDFO3BVjhYLdXPWaqU978AR"
        ]
         
        AF.request(url, method: .get, parameters: param).responseData(completionHandler: {
            response in
            switch response.result {
            case let .success(data): //요청 결과가 성공일 때
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CityCovidOverview.self, from: data) //매핑할 객체타입 : CityCovidOverview.self, data: 서버에서 전달받은 데이터
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            //요청 실패 시 case
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }) //request 메서드를 통해 API 호출을 함 -> 응답데이터를 받을 수 있는 메서드를 체이닝
        
    }
}

