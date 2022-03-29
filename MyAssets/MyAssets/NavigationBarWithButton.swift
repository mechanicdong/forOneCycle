//
//  NavigationBarWithButton.swift
//  MyAssets
//
//  Created by 이동희 on 2022/03/01.
//

import SwiftUI

struct NavigationBarWithButton: ViewModifier {
    var title: String = ""
    func body(content: Content) -> some View {
        return content
            .navigationBarItems(
                leading: Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .padding(),
                trailing: Button(
                    action: {
                    print("자산 추가 버튼 클릭됨")
                },
                 label: {
                     Image(systemName: "plus")
                         .padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 0))
                     Text("자산 추가")
                         .font(.system(size: 12))
                 }
            )
            .accentColor(.black)
                    .padding(EdgeInsets(top: -1, leading: 5, bottom: 0, trailing: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black) //테두리 설정
            )
        )
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { //명령형으로 네비게이션바의 색상 및 투명정도 설정
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = UIColor(white: 1, alpha: 0.5)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance //줄어들었을 때의 appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

extension View {
    //View가 직접적으로 함수를 사용할 수 있게
    func NavigationBarWithButtonStyle(_ title: String) -> some View {
        return self.modifier(NavigationBarWithButton(title: title))
    }
}

struct NavigationBarWithButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Color.gray.edgesIgnoringSafeArea(.all)
                .NavigationBarWithButtonStyle("내 자산")
        }
    }
}
