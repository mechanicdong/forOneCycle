//
//  AssetMenuButtonStyle.swift
//  MyAssets
//
//  Created by 이동희 on 2022/03/02.
//

import SwiftUI
//AssetMenu에서 사용되는 재사용가능한 Cell(using ButtonStyle)

struct AssetMenuButtonStyle: ButtonStyle {
    let menu: AssetMenu
    func makeBody(configuration: Configuration) -> some View {
        return VStack {
            Image(systemName: menu.systemImageName)
                .resizable()
                .frame(width: 30, height: 30)
                .padding([.leading, .trailing], 10)
            Text(menu.title)
                .font(.system(size: 12, weight: .bold))
        }
        .padding([.leading, .trailing], 10)
        .foregroundColor(.blue)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct AssetMenuButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        //for preview
        HStack(spacing: 24) {
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .creditScore))
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .bankAccount))
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .creditCard))
            Button("") {
                print("")
            }
            .buttonStyle(AssetMenuButtonStyle(menu: .cash))
        }
    }
}
