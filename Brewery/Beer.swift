//
//  Beer.swift
//  Brewery
//
//  Created by 이동희 on 2022/02/21.
//

import Foundation

struct Beer: Decodable {
    let id: Int?
    let name, taglineString, description, brewersTips, imageURL: String?
    let foodParing: [String]?
    
    //해시태그처럼 보이게끔 파싱
    var tagLine: String {
        //". "로 잘라 배열화
        let tags = taglineString?.components(separatedBy: ". ")
        //띄어쓰기 및 ".", "," 이 있거나 남아있다면 없애고 마지막에 # 붙이기
        let hashtags = tags?.map {
            "#" + $0.description.replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: ",", with: " #")
        }
        return hashtags?.joined(separator: " ") ?? "" //ex:#tag #good #example
    }
    
    //프로그램에서 사용할 key 값과 Server에서 받은 key 값이 다른 경우 표현
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case taglineString = "tagline"
        case imageURL = "image_url"
        case brewersTips = "brewers_tips"
        case foodParing = "food_paring"
    }
}
