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
    }
    @IBAction func tabDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexPath else { return }
        self.delegate?.didSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
}
