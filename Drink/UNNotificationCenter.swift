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
    //LocalAlarm 추가 함수
    func addNotificationRequest(by alert: Alert) {
        //Set content
        //first of all, set content of alert
        let content = UNMutableNotificationContent()
        content.title = "물 마실 시간이에요!"
        content.body = "세계 보건기구가 권장하는 하루 물 섭취량은 1.5~2L 입니다."
        content.sound = .default
        content.badge = 1
        
        //AddAlertViewController에서 설정된 pickedDate 일시의 alert trigger
        let component = Calendar.current.dateComponents([.hour, .minute], from: alert.date) //시, 분만 필요하므로
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn) //Switch가 on 일때만 반복
        
        //Set Request
        let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger )
        
        self.add(request, withCompletionHandler: nil)
    }
}
