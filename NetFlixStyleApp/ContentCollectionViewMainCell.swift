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
    
    //menuStackView Components
    let tvButton = UIButton()
    let movieButton = UIButton()
    let categoryButton = UIButton()
    
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
        
        [tvButton, movieButton, categoryButton].forEach {
            menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor //shadowColor는 CGColor를 상속받고 있음
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        
        tvButton.setTitle("TV 프로그램", for: .normal)
        movieButton.setTitle("영화", for: .normal)
        categoryButton.setTitle("카테고리 ▼", for: .normal)
        
        //menuStackView button IBAction
        tvButton.addTarget(self, action: #selector(tvButtonTapped), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    @objc func tvButtonTapped(sender: UIButton!) {
        print("TEST: TV Button Tapped")
    }
    
    @objc func movieButtonTapped(sender: UIButton!) {
        print("TEST: Movie Button Tapped")
    }
    
    @objc func categoryButtonTapped(sender: UIButton!) {
        print("TEST: Category Button Tapped")
    }
}
