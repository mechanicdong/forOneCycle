//
//  AssetBannerView.swift
//  MyAssets
//
//  Created by 이동희 on 2022/03/06.
//

import SwiftUI

struct AssetBannerView: View {
    let bannerList: [AssetBanner] = [
        AssetBanner.init(title: "공지사항", description: "추가된 공지사항을 확인하세요", backgroundColor: .systemRed),
        AssetBanner.init(title: "주말 이벤트", description: "주말 이벤트 놓치지 마세요!", backgroundColor: .systemYellow    ),
        AssetBanner.init(title: "깜짝 이벤트", description: "엄청난 이벤트에 놀라지마요", backgroundColor: .systemBlue),
        AssetBanner.init(title: "봄 프로모션", description: "봄....", backgroundColor: .green),
    ]
    
    @State private var currentPage = 0
    
    var body: some View {
        let bannerCards = bannerList.map { BannerCard(banner: $0) }
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: bannerCards, currentPage: $currentPage)
            PageControl(numberOfPages: bannerList.count, currentPage: $currentPage)
                .frame(width: CGFloat(bannerCards.count * 18))
                .padding(.trailing)
            
        }
    }
}

struct AssetBannerView_Previews: PreviewProvider {
    static var previews: some View {
        AssetBannerView()
            .aspectRatio(5/2, contentMode: .fit)
    }
}
