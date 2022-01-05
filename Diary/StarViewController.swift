//
//  StarViewController.swift
//  Diary
//
//  Created by 이동희 on 2021/12/26.
//

import UIKit

class StarViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    //즐겨찾기 탭에 즐겨찾기 한 일기만 표시되도록 구현
    private var diaryList = [Diary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadStarDiaryList()
    }
    
    //collectionView 속성 설정하는 프로퍼티
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    //date type으로 전달받으면 문자열로 변환하는 메소드 생성
    private func dateToString(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    //UserDefaults에서 즐겨찾기된 항목만 가져오기, 우선 메서드 설정
    private func loadStarDiaryList() {
        let userDefaults = UserDefaults.standard
        //diaryList key value를 넘겨줘서 일기장을 가져오기
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String : Any]] else { return }
        //불러온 data를 diaryList 배열에 넣어주기
        self.diaryList = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let contents = $0["contents"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let isStar = $0["isStar"] as? Bool else { return nil }
            return Diary(title: title, contents: contents, date: date, isStar: isStar)
        }.filter({
            $0.isStar == true //즐겨찾기 된 일기만 가져오기
        }).sorted(by: {
            $0.date.compare($1.date) == .orderedDescending //최신순
        })
        self.collectionView.reloadData()
    }
}

//dataSource 프로토콜 및 필수함수 구현
extension StarViewController: UICollectionViewDataSource {
    //필수 메서드 1
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //즐겨찾기 된 다이어리 리스트 배열의 리스트 개수만큼 셀에 표시되게 구현
        return self.diaryList.count
    }
    //필수 메서드 2
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarCell", for: indexPath) as? StarCell else { return UICollectionViewCell() } //없으면 빈 셀이 반환되도록
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        return cell //CollectionView에 일기장 목록을 표시할 준비 완료
    }
}
//UICollectionViewdelegateFlowlayout을 채택하여 CollectionView에 레이아웃 구현
extension StarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 80)
    }
}
