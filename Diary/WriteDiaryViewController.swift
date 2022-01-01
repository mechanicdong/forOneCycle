//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by 이동희 on 2021/12/26.
//

import UIKit

protocol WriteDiaryViewDelegate : AnyObject {
    func didSelectRegister(diary: Diary) //일기가 작성된 Diary 객체 전달
}

class WriteDiaryViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dataTextField: UITextField!
    @IBOutlet var confirmButton: UIBarButtonItem!
    
    //날짜버튼을 선택했을 때 키패드가 아닌 데이트피커가 뜨도록 설정
    private let datePicker = UIDatePicker()
    private var diaryDate : Date? //datePicker에서 선택된 data를 저장
    
    weak var delegate : WriteDiaryViewDelegate? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
        self.configureInputField()
        //제목, 내용, 날짜 중 하나라도 입력되어 있지 않으면 '등록버튼'을 비활성화
        self.confirmButton.isEnabled = false
    }
    
    //diaryCell의 테두리 추가 20211227@LDH start
    private func configureContentsTextView() {
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0) //모든 para값은 0.0~1.0이므로 /255를 해줌
        //layer관련 컬러는 cgColor로 설정
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0 //둥글게
    }
    //diaryCell의 테두리 추가 20211227@LDH end
    
    //날짜버튼을 선택했을 때 키패드가 아닌 데이트피커가 뜨도록 설정 20211227@LDH start
    private func configureDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko-KR") //datepicker가 한국어로 표시
        self.dataTextField.inputView = self.datePicker
    } //값이 바뀔 때마다 datePickerValueDidChange 메서드를 호출함
    //날짜버튼을 선택했을 때 키패드가 아닌 데이트피커가 뜨도록 설정 20211227@LDH end
    
    //제목, 내용, 날짜 중 하나라도 입력되어 있지 않으면 '등록버튼'을 비활성화
    private func configureInputField() {
        self.contentsTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dataTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    //등록버튼을 눌렀을 때 다이어리 객체 생성 및 delegate에 정의한 didSelectRegister 메서드를 호출해서 메서드 파라미터에 생성된 Diary 객체를 전달
    @IBAction func tabConfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else { return }
        guard let contents = self.contentsTextView.text else { return }
        guard let date = self.diaryDate else { return }
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        self.delegate?.didSelectRegister(diary: diary)
        self.navigationController?.popViewController(animated: true)
    }
    
    //날짜버튼을 선택했을 때 키패드가 아닌 데이트피커가 뜨도록 설정 20211227@LDH start
    //configureDatePicker 메서드의 selector 값 설정
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formmater = DateFormatter() //날짜와 텍스트를 반환해주는 역할
        formmater.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR") //한국어로 설정
        self.diaryDate = datePicker.date
        self.dataTextField.text = formmater.string(from: datePicker.date)
        /*dateTextField는 텍스트를 키보드로 입력받는 형태가 아니기에 dataTextFieldDidChage 메서드가 실행되지 않음
        -> 데이트피커의 날짜가 변경될 때마다 EditingChange 액션을 발생시켜 dateTextFieldDidChange 메서드가 호출되게 구현 */
        self.dataTextField.sendActions(for: .editingChanged)
    }
    //날짜버튼을 선택했을 때 키패드가 아닌 데이트피커가 뜨도록 설정 20211227@LDH end
    
    //제목이 입력될 때마다 입력버튼 활성화 여부 판단
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    //날짜가 입력될 때마다 입력버튼 활성화 여부 판단
    @objc private func dateTextFieldDidChange(_ textField : UITextField) {
        self.validateInputField()
    }
    
    //빈 곳을 클릭했을 때 키보드나 datePicker가 사라지도록 설정, User가 화면을 터치하면 실행되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 등록버튼의 활성화 여부 판단 메서드
    private func validateInputField() {
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dataTextField.text?.isEmpty ?? true) && (!self.contentsTextView.text.isEmpty)
    }
}

//제목, 내용, 날짜 중 하나라도 입력되어 있지 않으면 '등록버튼'을 비활성화
extension WriteDiaryViewController : UITextViewDelegate {
    //Textview에 텍스트가 입력 될 때마다 호출되는 메서드
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}
