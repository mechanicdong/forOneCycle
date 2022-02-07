//
//  Alert.swift
//  Drink
//
//  Created by 이동희 on 2022/02/07.
//

import Foundation

//list에 보여지는 alert 객체 생성
struct Alert: Codable {
    var id: String = UUID().uuidString
    let date: Date
    let isOn: Bool
    
    var time: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var meridiem: String {
        let meridiemFormatter = DateFormatter()
        meridiemFormatter.dateFormat = "a" //오전, 오후를 표현하는 데이터포맷
        meridiemFormatter.locale = Locale(identifier: "ko")
        return meridiemFormatter.string(from: date)
    }
}
