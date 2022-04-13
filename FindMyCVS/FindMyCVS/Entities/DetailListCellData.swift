//
//  DetailListCellData.swift
//  FindMyCVS
//
//  Created by 이동희 on 2022/04/13.
//

//Cell에서 보여지는 데이터만을 위한 entity

import Foundation

struct DetailListCellData {
    let placeName: String
    let address: String
    let distance: String
    let point: MTMapPoint
}
