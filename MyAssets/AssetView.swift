//
//  AssetView.swift
//  MyAssets
//
//  Created by 이동희 on 2022/03/02.
//

import SwiftUI

struct AssetView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    Spacer() //약간의 공간
                    AssetMenuGridView()
                }
            }
            .background(Color.gray.opacity(0.2))
            .NavigationBarWithButtonStyle("내 자산")
        }
    }
}

struct AssetView_Previews: PreviewProvider {
    static var previews: some View {
        AssetView()
    }
}
