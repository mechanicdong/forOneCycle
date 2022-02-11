//
//   EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 이동희 on 2022/01/21.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        //처음 이메일 입력화면으로 넘어왔을 때 커서가 자동으로 들어가도록(편의성)
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationBar 보이기
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) {
            [weak self] authResult, error in //순환참조 방지 weak self
            guard let self = self else { return }
            //클로저 내부에서 self를 임시적으로 strong reference로 가지고 있을 수 있는데, 클로저 내부에서 guard 구문을 사용하여 self를 언랩핑 해주는 것
            //클로저 내부에서 self를 strong reference로 사용할 수 있고, 외부에서 캡처한 self가
            //nil이 될 경우 guard 구문에서 return 시키므로 메모리 릭에 대한 걱정 없이 사용할 수 있다.
            
            //Error 처리(ex: Email 중복)
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: //이미 가입한 계정일 때, 17007 error code는 디버깅 후 'po error'를 치면 확인 가능
                    //로그인 하기를 따로 제공하기
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else { //error가 발생하지 않으면 메인으로
                self.showMainViewController()
            }
        } //end of 신규 사용자 생성 closure
    } // end of nextButtonTapped
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "mainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    //Firebase 인증을 통한 로그인
    private func loginUser(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
}

//delegate 설정
extension EnterEmailViewController: UITextFieldDelegate {
    //return button 클릭 시 키보드가 내려가게
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
     
    //이메일, 비밀번호 입력값을 보고 다음버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        var isEmailEmpty: Bool = false
        var isPasswordEmpty: Bool = false
        if let EmailEmpty: String = "" as? String {
             isEmailEmpty = false
        }
        if let passwordEmpty: String = "" as? String {
             isPasswordEmpty = false
        }
        //let isEmailEmpty = emailTextField.text == ""
        //let isPasswordEmpty = passwordTextField.text = ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
 
