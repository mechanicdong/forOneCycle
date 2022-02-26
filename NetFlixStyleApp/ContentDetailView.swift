//
//  ContentDetailView.swift
//  NetFlixStyleApp
//
//  Created by 이동희 on 2022/02/26.
//

import SwiftUI

struct ContentDetailView: View {
    //propertywrapper: 내부 상태 변화를 표시
    @State var item: Item?
    
    var body: some View {
        VStack {
            if let item = item {
                Image(uiImage: item.image)
                    .aspectRatio(contentMode: .fit)
                
                Text(item.description)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding() //padding: 약간의 좌우 간격
                
            } else {
                Color.white //background as white
            }
        }
    }

}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //dummy item
        let item0 = Item(description: "흥미진진, 판타지, 애니메이션, 액션, 멀티캐스팅", imageName: "poster0")
        ContentDetailView(item: item0)
    }
}
