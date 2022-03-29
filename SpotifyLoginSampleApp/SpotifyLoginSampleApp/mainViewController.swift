//
//  mainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 이동희 on 2022/01/21.
//

import UIKit
import FirebaseAuth

class mainViewController: UIViewController {
        
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        //Login 할 경우 Firebase 인증을 통해 Login 한 사용자의 Email 가져오기
        let email = Auth.auth().currentUser?.email ?? "고객" //없을경우 '고객'이라고 뜸
        
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
        
        //Email SignIn이 아니라면 (=소셜 로그인이 아니라면) PW 변경 버튼이 보이지 않도록
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error: signout \(signOutError.localizedDescription)")
        }
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        let email = Auth.auth().currentUser?.email ?? ""
        //현재 사용자 ID로 비밀번호를 변경할 수 있는 이메일을 보내기
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
        
    }
}
