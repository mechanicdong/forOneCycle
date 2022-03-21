//
//  StationResponseModel.swift
//  SubwayStation
//
//  Created by 이동희 on 2022/03/20.
//

import Foundation

struct StationResponseModel: Decodable {
    //너무 복잡하므로(StationResponseModel().searchInfo.row)
    //StationResponseModel().stations 로 사용시 간단하게 됨
    var stations: [Station] { searchInfo.row }
    
    private let searchInfo: SearchInfoBySubwayNameServiceModel
    enum Codingkeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubwayNameServiceModel: Decodable {
        var row: [Station] = []
    }
}

struct Station: Decodable {
    let stationName: String
    let lineNumber: String
    
    //실제 API 데이터와 우리가 사용할 변수명이 다르므로
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
}


