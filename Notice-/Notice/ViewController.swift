//
//  ViewController.swift
//  Notice
//
//  Created by 이동희 on 2022/02/05.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAnalytics

class ViewController: UIViewController {
    //원격 구성은 key-value 구성의 storage
    var remoteConfig: RemoteConfig?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfig = RemoteConfig.remoteConfig()
        
        let setting = RemoteConfigSettings()
        //테스트를 위해 새로운 값을 패치하는 interval을 최소화하여 최대한 자주 원격구성 데이터를 가져올 수 있게 설정
        setting.minimumFetchInterval = 0
        remoteConfig?.configSettings = setting
        
        remoteConfig?.setDefaults(fromPlist: "RemoteConfigDefaults")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNotice()
    }
}

//Remote Config
extension ViewController {
    func getNotice() {
        guard let remoteConfig = remoteConfig else { return }
        
        remoteConfig.fetch { [weak self] status, _ in
            //data를 정상적으로 가져왔다면
            if status == .success {
                remoteConfig.activate(completion: nil)
            } else {
                print("ERROR: Config not fetched")
            }
            
            guard let self = self else { return }
            if !self.isNoticeHidden(remoteConfig) {
                let noticeVC = NoticeViewController(nibName: "NoticeViewController", bundle: nil)
                
                noticeVC.modalPresentationStyle = .custom
                noticeVC.modalTransitionStyle = .crossDissolve
                
                let title = (remoteConfig["title"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let detail = (remoteConfig["detail"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let date = (remoteConfig["date"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                
                noticeVC.noticeContents = (title: title, detail: detail, date: date)
                self.present(noticeVC, animated: true, completion: nil)
            } else {
                self.showEventAlert()
            }
        }
    }
    
    func isNoticeHidden(_ remoteConfig: RemoteConfig) -> Bool {
        return remoteConfig["isHidden"].boolValue //Reading isHidden key value
    }
}

// A/B Testing
extension ViewController {
    // Popup이 안뜰 때 활성화
    func showEventAlert() {
        guard let remoteConfige = remoteConfig else { return }
        
        remoteConfige.fetch { status, _ in
            if status == .success {
                remoteConfige.activate(completion: nil)
            } else {
                print("ERROR: Config not fetched")
            }
            
            let message = remoteConfige["mesaage"].stringValue ?? ""
            let confirmAction = UIAlertAction(title: "확인하기", style: .default) {_ in
                //Google Analytics, 확인버튼을 눌렀을 때 실제 Event Logging
                Analytics.logEvent("promotion_alert", parameters: nil)
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel , handler: nil)
            let alertController = UIAlertController(title: "깜짝 이벤트", message: message, preferredStyle: .alert)
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
}
