//
//  ViewController.swift
//  Diary
//
//  Created by 이동희 on 2021/12/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    //Diary CollectionView 생성 20220101@LDH
    private var diaryList = [Diary]() {
        didSet {
            self.saveDiaryList() //DiaryList 배열에 일기가 추가되거나 변경될때마다 유저디폴트에 저장되게 됨
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiaryList()
        //일기장 메인화면에서도 옵저버를 추가하여 갱신되도록 수정
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("editDiary"), //editDiary 관찰
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(starDiaryNotification(_:)),
            name: NSNotification.Name("starDiary"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteDiaryNotification(_:)),
            name: Notification.Name("deleteDiary"),
            object: nil)
    }
    
    
    // 등록된 일기가 CollectionView에 표시되도록 구현
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return } //전달받은 다이어리 객체를 가져오기
        //guard let row = notification.userInfo?["indexPath.row"] as? Int else { return } //indexPath의 row값 가져오기
        //indexPath대신 uuidString을 활용하여 이벤트를 받는 쪽도 구현
        guard let index = self.diaryList.firstIndex(where: {$0.uuidString == diary.uuidString}) else {return}
        //self.diaryList[row] = diary
        self.diaryList[index] = diary
        self.diaryList = self.diaryList.sorted(by:  {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }
    
    @objc func starDiaryNotification(_ notification: Notification) {
        guard let starDiary = notification.object as? [String: Any] else { return }
        guard let isStar = starDiary["isStar"] as? Bool else { return }
        
        //guard let indexPath = starDiary["indexPath"] as? IndexPath else { return }
        guard let uuidString = starDiary["uuidString"] as? String else { return }
        guard let index = self.diaryList.firstIndex(where: { $0.uuidString == uuidString }) else { return }
        
        //self.diaryList[indexPath.row].isStar = isStar //즐겨찾기 여부를 전달받아 업데이트
        self.diaryList[index].isStar = isStar
    }
    
    @objc func deleteDiaryNotification(_ notification: Notification) {
        //guard let indexPath = notification.object as? IndexPath else { return }
        guard let uuidString = notification.object as? String else { return }
        guard let index = self.diaryList.firstIndex(where: {$0.uuidString == uuidString}) else { return }
        //self.diaryList.remove(at: indexPath.row)
        self.diaryList.remove(at: index)
        //self.collectionView.deleteItems(at: [indexPath])
        self.collectionView.deleteItems(at: [IndexPath(row: index, section: 0)]) //단일 section이므로
    }
        
    // 일기작성 화면의 이동은 segueway 이용 -> prepare method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let writeDiaryViewController = segue.destination as? WriteDiaryViewController {
            writeDiaryViewController.delegate = self
        }
    }
    
    // App 재기동 후에도 데이터가 유지되도록 설정
    private func saveDiaryList() {
        //배열에 있는 데이터를 딕셔너리 형태로
        let date = self.diaryList.map {
            [
                "uuidString" : $0.uuidString,
                "title" : $0.title,
                "contents" : $0.contents,
                "date" : $0.date,
                "isStar" : $0.isStar
            ]
        }
        let userDefaults = UserDefaults.standard //UserDefaults에 접근하도록
        userDefaults.set(date, forKey: "diaryList")
    }
    
    //UserDefaults에 저장된 값을 불러오기
    private func loadDiaryList() {
        let userDefaults = UserDefaults.standard
        //일기장 리스트 가져오기, object는 AnyType으로 return되기 때문에 Dictionary 배열 형태로 타입캐스팅
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
        //불러온 배열을 DiaryList배열에 넣어줘야 함
        self.diaryList = data.compactMap {
            //저장된 uuidString도 불러오기 20200108@LDH
            guard let uuidString = $0["uuidString"] as? String else { return nil }
            guard let title = $0["title"] as? String else { return nil }
            guard let contents = $0["contents"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let isStar = $0["isStar"] as? Bool else { return nil }
            return Diary(uuidString: uuidString ,title: title, contents: contents, date: date, isStar: isStar)
        }
        //일기를 불러올 때 최신순으로 불러오도록 설정
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    //date type으로 전달받으면 문자열로 변환하는 메소드 생성
    private func dateToString(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

extension ViewController: WriteDiaryViewDelegate {
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary) //일기작성화면에서 일기가 등록될 때마다 diary 배열에 등록된 일기가 추가
        //일기를 등록할 때 최신순으로 등록하도록 설정
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() }
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dataLabel.text = self.dateToString(date: diary.date)
        return cell
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
        let diary = self.diaryList[indexPath.row]
        viewController.diary = diary
        viewController.indexPath  = indexPath
        // viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController : DiaryDetailViewDelegate {
/*    func didSelectDelete(indexPath : IndexPath) {
        self.diaryList.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
    }
*/
    
/*    func didSelectStar(indexPath: IndexPath, isStar: Bool) {
        self.diaryList[indexPath.row].isStar = isStar //즐겨찾기 여부를 전달받아 업데이트
    }
 */
}
