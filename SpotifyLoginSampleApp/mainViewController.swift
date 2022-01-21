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
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
