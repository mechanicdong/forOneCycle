//
//  AssetSummaryData.swift
//  MyAssets
//
//  Created by 이동희 on 2022/03/07.
//

import SwiftUI

class AssetSummaryData: ObservableObject {
    //decoding된 assets data 내보내기(@Published, class에서만 작동)
    @Published var assets: [Asset] = load("assets.json")
}

//assets.json을 받는 전역 함수
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else { fatalError(filename + "을 찾을 수 없습니다") }
    //파일을 찾았다면
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError(filename + "을 찾을 수 없습니다")
    }
    //data를 잘 가져 왔다면 decode
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError(filename + "을 \(T.self)로 파싱할 수 없습니다")
    }
}
