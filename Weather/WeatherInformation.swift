//
//  WeatherInformation.swift
//  Weather
//
//  Created by 이동희 on 2022/01/15.
//

import Foundation

//Codable 프로토콜: 자신을 변환하거나 외부표현으로 변환하는 타입(ex: JSON)
//-> JSON Decoding & EnCoding이 모두 가능
struct WeatherInformation: Codable {
    let weather: [Weather]
    let temp: Temp
    //도시이름 가져오는 프로퍼티
    let name: String
    
    enum CodingKeys: String, CodingKey {
    case weather
    case temp = "main"
    case name
    }
}

//JSON 타입의 Key와 사용자가 정의한 프로퍼티 이름과 타입을 일치하게 정의(날씨 API)
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

//여기선 일부로 JSON Key와 프로퍼티 이름을 다르게 해봄
struct Temp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    
    enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case minTemp = "temp_min"
    case maxTemp = "temp_max"
    }
}

