//
//  Content.swift
//  NetFlixStyleApp
//
//  Created by 이동희 on 2022/02/15.
//

import Foundation
import UIKit

//사용자가 데이터에 write 할 작업이 없기 때문에 Decodable(읽기작업)만 함
struct Content: Decodable {
    let sectionType: SectionType
    let sectionName: String
    let contentItem: [Item]
    
    enum SectionType: String, Decodable {
        case basic
        case main
        case large
        case rank
    }
}

struct Item: Decodable {
    let description: String
    let imageName: String
    
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
}


