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
        //즐겨찾기 수정, 삭제 Notification 이벤트를 즐겨찾기에 옵저빙하여 이벤트가 일어나면 일기장화면, 즐겨찾기화면 모두 동기화되게 구현
        self.loadStarDiaryList()
        //수정이 일어났을 때 관찰하는 Observer 추가
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("editDiary"),
            object: nil)
        //star Toggle이 일어났을 때 Observer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(starDiaryNotification(_:)),
            name: NSNotification.Name("starDiary"),
            object: nil)
        //삭제가 일어났을 때
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteDiaryNotification(_:)),
            name: NSNotification.Name("deleteDiary"),
            object: nil)
    }

/*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadStarDiaryList()
    }
*/
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
        //self.collectionView.reloadData()
    }
    //수정이 일어났을 때 호출되는 메서드
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else { return }
        self.diaryList[row] = diary
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        collectionView.reloadData()
    }
    
    //star Toggle 이벤트가 발생했을 때 호출되는 메서드
    @objc func starDiaryNotification(_ notification: Notification) {
        guard let starDiary = notification.object as? [String: Any] else { return }
        guard let diary = starDiary["diary"] as? Diary else { return } //즐겨찾기 한 다이어리 객체 가져오기
        guard let isStar = starDiary["isStar"] as? Bool else { return }
        guard let indexPath = starDiary["indexPath"] as? IndexPath else { return }
        if isStar {
            self.diaryList.append(diary)
            self.diaryList = self.diaryList.sorted(by: {
                $0.date.compare($1.date) == .orderedDescending
            })
            self.collectionView.reloadData()
        } else {
            //즐겨찾기가 해제되면 삭제되게 만들고
            self.diaryList.remove(at: indexPath.row)
            self.collectionView.deleteItems(at: [indexPath])
        }
    }
    
    //
    @objc func deleteDiaryNotification(_ notification: Notification) {
        guard let indexPath = notification.object as? IndexPath else { return }
        self.diaryList.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
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

//즐겨찾기에서 항목을 선택하면 상세화면으로 이동 구현
extension StarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
        let diary = self.diaryList[indexPath.row]
        viewController.diary = diary
        viewController.indexPath = indexPath
        self.navigationController?.pushViewController(viewController, animated: true )
    } 
}
