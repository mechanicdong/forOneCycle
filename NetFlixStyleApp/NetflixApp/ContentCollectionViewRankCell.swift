//
//  ContentCollectionViewRankCell.swift
//  NetFlixStyleApp
//
//  Created by 이동희 on 2022/02/18.
//

import UIKit

class ContentCollectionViewRankCell: UICollectionViewCell {
    let imageView = UIImageView()
    let rankLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //set ContentView's layout (contentView = UICollectionViewCell이 가지는 기본 View)
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        //set imageView
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8) //SuperView보다 0.8정도
        }
        
        //set rankLabel
        rankLabel.font = .systemFont(ofSize: 100, weight: .black)
        rankLabel.textColor = .white
        contentView.addSubview(rankLabel)
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(25)
        }
        
    }
}
