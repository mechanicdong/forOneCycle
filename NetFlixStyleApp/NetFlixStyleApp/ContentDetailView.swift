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
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) //safety area까지 검정색 설정
            ZStack(alignment: .bottom) {
                if let item = item {
                    Image(uiImage: item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                    
                    Text(item.description)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding() //padding: 약간의 좌우 간격
                        .foregroundColor(.primary)
                        .background(Color.primary
                                        .colorInvert()
                                        .opacity(0.75)) //투명도 설정
                    
                } else {
                    Color.white //background as white
                }
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
