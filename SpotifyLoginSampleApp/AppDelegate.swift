//
//  AppDelegate.swift
//  SpotifyLoginSampleApp
//
//  Created by 이동희 on 2022/01/21.
//

import UIKit
import Firebase
import GoogleSignIn

@main //GIDSignInDelegate 참조 과정에서 GIDSignIn version을 <5.0.0으로 pod에서 수정함
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate{
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Firebase 초기화
        FirebaseApp.configure()
        
        //Google Login Delegate 추가
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    //OpenURL 메서드 : 구글에 인증프로세스가 끝날 때 앱이 수신하는 URL을 처리하는 역할
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("ERROR Google Sign In \(error.localizedDescription)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { _, error in
            self.showMainViewController()
        }
    }
    //등록 후 메인화면 진입
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "mainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
    }
}

