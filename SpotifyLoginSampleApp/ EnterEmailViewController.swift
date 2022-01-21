//
//   EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 이동희 on 2022/01/21.
//

import UIKit

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
 
