//
//  StationArrivalDataResponseModel.swift
//  SubwayStation
//
//  Created by 이동희 on 2022/03/21.
//

import Foundation

struct StationArrivalDataResponseModel: Decodable {
    var realtimeArrivalList: [RealTimeArrival] = []
    
    struct RealTimeArrival: Decodable {
        let line: String //~행
        let remainTime: String //도착까지 남은 시간
        let currentStation: String
        
        enum CodingKeys: String, CodingKey {
            case line = "trainLineNm"
            case remainTime = "arvlMsg2"
            case currentStation = "arvlMsg3"
        }
    }
}
