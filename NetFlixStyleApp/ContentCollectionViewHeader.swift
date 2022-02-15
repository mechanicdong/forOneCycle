//
//  ContentCollectionViewHeader.swift
//  NetFlixStyleApp
//
//  Created by 이동희 on 2022/02/15.
//

import UIKit
import SnapKit

//Header, Footer 설정은 반드시 UICollectionReusableView
class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        //UICollectionReusableView의 subView 추가
        addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
