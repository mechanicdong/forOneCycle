//
//  AppDelegate.swift
//  Drink
//
//  Created by 이동희 on 2022/02/07.
//

import UIKit
import NotificationCenter
import UserNotifications //For users approval at first time

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let userNotificationCenter = UNUserNotificationCenter.current()
        
        //Set Notification Delegate
        UNUserNotificationCenter.current().delegate = self
        
        //For users approval at first time
        let authrizationOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotificationCenter.requestAuthorization(options: authrizationOptions) { _, error in
            if let error = error {
                print("ERROR: notification authrization request \(error.localizedDescription)")
            }
            
        }
        return true
    }

    

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

//Set Notification Delegate
//Notification을 보내기 전에 어떤 Handling을 할지 결정
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner, .list, .badge, .sound])
            
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}


