//
//  Asset.swift
//  MyAssets
//
//  Created by 이동희 on 2022/03/07.
//

import Foundation

class Asset: Identifiable, ObservableObject, Decodable {
    let id: Int
    let type: AssetMenu
    let data: [AssetData]
    
    init(id: Int, type: AssetMenu, data: [AssetData]) {
        self.id = id
        self.type = type
        self.data = data
    }
}

class AssetData: Identifiable, ObservableObject, Decodable {
    let id: Int
    let title: String
    let amount: String
    
    //AssetData가 구조체가 아닌 class 이기에 init
    init(id: Int, title: String, amount: String) {
        self.id = id
        self.title = title
        self.amount = amount
    }
}
