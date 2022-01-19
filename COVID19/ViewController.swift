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
                debugPrint("success \(result)")
                
            case let .failure(error):
                debugPrint("Error \(error)")
            }
        })
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

