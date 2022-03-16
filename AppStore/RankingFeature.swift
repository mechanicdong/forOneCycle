//
//  RankingFeature.swift
//  AppStore
//
//  Created by 이동희 on 2022/03/16.
//

import Foundation

struct RankingFeature: Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}
