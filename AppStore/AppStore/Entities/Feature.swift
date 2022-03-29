//
//  Feature.swift
//  AppStore
//
//  Created by 이동희 on 2022/03/16.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
