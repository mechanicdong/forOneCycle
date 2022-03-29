//
//  TodayCollectionViewCell.swift
//  AppStore
//
//  Created by 이동희 on 2022/03/13.
//

import UIKit
import SnapKit
import Kingfisher

final class TodayCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true //imageView 크기에 따른 image 짤림 방지
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    
    func setup(today: Today) { // for checking setup
        setupSubViews()
        //set shadow color
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        
        subTitleLabel.text = today.subTitle
        descriptionLabel.text = today.description
        titleLabel.text = today.title
        //using kingfisher
        //String value인 imageURL을 URL로 변환시켜야 함
        if let imageURL = URL(string: today.imageURL) {
            imageView.kf.setImage(with: imageURL)
        } //if let인 이유는 URL 초기화 메소드의 리턴값이 Optional이기 때문
    }
}

private extension TodayCollectionViewCell {
    func setupSubViews() {
        [imageView, subTitleLabel, titleLabel, descriptionLabel]
            .forEach {
                addSubview($0)
            }
        subTitleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(24.0)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(subTitleLabel)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4.0)
        }
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(24.0)
        }
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
