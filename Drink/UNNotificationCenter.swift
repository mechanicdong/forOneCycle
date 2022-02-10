//
//  UNNotificationCenter.swift
//  Drink
//
//  Created by 이동희 on 2022/02/10.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
     //여기서 Alert Instance를 받아 request를 생성 -> 최종적으로 Notification Center에 추가하는 함수 선언
    func addNotificationRequest(by alert: Alert) {
        //Set content
        //first of all, set content of alert
        let content = UNMutableNotificationContent()
        content.title = "물 마실 시간이에요!"
        content.body = "세계 보건기구가 권장하는 하루 물 섭취량은 1.5~2L 입니다."
        content.sound = .default
        content.badge = 1
    }
}
