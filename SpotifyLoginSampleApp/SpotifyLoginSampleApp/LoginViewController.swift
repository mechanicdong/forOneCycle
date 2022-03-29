//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 이동희 on 2022/01/21.
//

import GoogleSignIn
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton! //UIButton을 상속
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //NavigationBar 숨기기
        navigationController?.navigationBar.isHidden = true
        
        //Google Sign In
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        //fireBase 인증
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        //fireBase 인증
        
    }
    
}
