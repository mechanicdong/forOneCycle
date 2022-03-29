//
//  CreditCard.swift
//  CreditCardList
//
//  Created by 이동희 on 2022/01/25.
//

import Foundation

//JSON 정보를 읽고 쓰는 곳 -> Codable 상속하는 객체를 생성
//읽을 때: Decoding, 쓸 때: Encoding

struct CreditCard: Codable {
    let id: Int
    let rank: Int
    let name: String
    let cardImageURL: String
    let promotionDetail: PromotionDetail
    let isSelected: Bool? //추후 사용자가 카드 선택시 생성됨
}

struct PromotionDetail: Codable {
    let companyName: String
    let period: String
    let amount: Int
    let condition: String
    let benefitCondition: String
    let benefitDetail: String
    let benefitDate: String    
}
