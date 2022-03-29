//
//  AssetSectionView.swift
//  MyAssets
//
//  Created by 이동희 on 2022/03/07.
//

import SwiftUI

struct AssetSectionView: View {
    @ObservedObject var assetSection: Asset
    var body: some View {
        VStack(spacing: 20) {
            AssetSectionHeaderView(title: assetSection.type.title)
            ForEach(assetSection.data) { asset in
                HStack {
                    Text(asset.title)
                        .font(.title)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(asset.amount)
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                Divider()
            } //end of ForEach
        }
        .padding()
    }
}

struct AssetSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let asset = Asset(
            id: 0,
            type: .bankAccount,
            data: [
                AssetData(id: 0, title: "신한은행", amount: "530,000원"),
                AssetData(id: 1, title: "국민은행", amount: "15,530,000원"),
                AssetData(id: 2, title: "농협은행", amount: "25,530,000원")
            ]
        )
        AssetSectionView(assetSection: asset)
    }
}
