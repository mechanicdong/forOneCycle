//
//  ContentCollectionViewMainCell.swift
//  NetFlixStyleApp
//
//  Created by 이동희 on 2022/02/19.
//

import UIKit

class ContentCollectionViewMainCell: UICollectionViewCell {
    //바탕이 되는 두 가지 StackView 생성
    let baseStackView = UIStackView()
    let menuStackView = UIStackView()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [baseStackView, menuStackView].forEach {
            contentView.addSubview($0)
        }
        
        //Set baseStackView Layout
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        
        //Set Autolayout
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        //Set menuStackView Layout
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        menuStackView.distribution = .equalSpacing
        menuStackView.spacing = 20
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }
}
