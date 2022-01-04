//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by 이동희 on 2021/12/26.
//

import UIKit

//삭제 버튼을 눌렀을 때 해당 일기 삭제
protocol DiaryDetailViewDelegate : AnyObject {
    func didSelectDelete(indexPath : IndexPath) 
}

class DiaryDetailViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateLabel: UILabel!
    
    weak var delegate : DiaryDetailViewDelegate?
    
    var diary: Diary?
    var indexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView() {
        guard let diary = self.diary else { return }
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = self.dateToString(date: diary.date)
    }
    
    //date type으로 전달받으면 문자열로 변환하는 메소드 생성
    private func dateToString(date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }

    @IBAction func tabEditButton(_ sender: UIButton) {
        //수정버튼을 누르면 WriteDiaryViewController 화면이 Push
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        guard let indexPath = self.indexPath else { return }
        guard let diary = self.diary else { return }
        viewController.diaryEditorMode = .edit(indexPath, diary)
        //Notification Observing 구현
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)),
                                               name: NSNotification.Name("editDiary"), object: nil)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
     
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return } //host에서 보낸 diary 객체를 받기
        guard let row = notification.userInfo?["indexPath.row"] as? Int else { return }
        self.diary = diary
        self.configureView() //수정된 내용으로 View가 업데이트 되도록 설정
    }
    
    @IBAction func tabDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexPath else { return }
        self.delegate?.didSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
    //instance가 deinit 될 때 해당인스턴스에 추가된 옵저버가 모두 제거되도록 하기
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
