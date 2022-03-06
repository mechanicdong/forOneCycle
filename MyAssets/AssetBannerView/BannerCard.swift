//
//  BannerCard.swift
//  MyAssets
//
//  Created by 이동희 on 2022/03/04.
//

import SwiftUI

struct BannerCard: View {
    var banner: AssetBanner
    var body: some View {

//1. ZStack 사용
        ZStack {
            Color(banner.backgroundColor)
            VStack {
                Text(banner.title)
                    .font(.title)
                Text(banner.description)
                    .font(.subheadline)
            }
        }
        
/* 2. Color에 Overlay를 하는 방법
        Color(banner.backgroundColor)
            .overlay(
                VStack {
                    Text(banner.title)
                        .font(.title)
                    Text(banner.description)
                        .font(.subheadline)
                }
           )
 */
    }
}

struct BannerCard_Previews: PreviewProvider {
    static var previews: some View {
        let banner0 = AssetBanner(title: "공지사항", description: "추가된 공지사항을 확인하세요", backgroundColor: .red)
        BannerCard(banner: banner0)
    }
}
