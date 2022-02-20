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
    
    //contentStackView (in baseStackView)
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView()
    
    //set contentStackView's Button
    let plusButton = UIButton()
    let playButton = UIButton()
    let infoButton = UIButton()
    
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
        
        //StackView에 넣을 땐 addArrangedSubview
        [imageView, descriptionLabel, contentStackView].forEach {
            baseStackView.addArrangedSubview($0)
        }
        
        //set imageView
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        //set descriptionLabel
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        
        //set contentStackView
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        
        [plusButton, infoButton].forEach {

            var configuration = UIButton.Configuration.filled()
            configuration.title = $0.titleLabel?.text
            configuration.image = $0.imageView?.image
            configuration.imagePadding = 10
            configuration.baseBackgroundColor = .black
            $0.configuration = configuration
//            $0.titleLabel?.font = .systemFont(ofSize: 13)
//            $0.setTitleColor(.white, for: .normal)
//            $0.imageView?.tintColor = .white
            
        }
        
        plusButton.setTitle("내가 찜한 컨텐츠", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
                
        infoButton.setTitle("정보", for: .normal)
        infoButton.setImage(UIImage(systemName: "info"), for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        //contentStackView.addArrangedSubview(playButton)
        playButton.setTitle("재생 ▶︎", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.layer.cornerRadius = 3
        playButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        playButton.addTarget(self , action: #selector(playButtonTapped) , for: .touchUpInside)
        
        [plusButton, playButton, infoButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
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
            $0.titleLabel?.font = .systemFont(ofSize: 15)
        }
        
        tvButton.setTitle("시리즈", for: .normal)
        movieButton.setTitle("영화", for: .normal)
        categoryButton.setTitle("카테고리 ▼", for: .normal)
        
        //menuStackView button IBAction
        tvButton.addTarget(self, action: #selector(tvButtonTapped), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView)
            $0.leading.trailing.equalToSuperview().inset(65)
            //menuStackView.spacing = 5
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
    
    @objc func plusButtonTapped(sender: UIButton!) {
        print("TEST: Plus Button Tapped")
    }
    
    @objc func infoButtonTapped(sender: UIButton!) {
        print("TEST: Info Button Tapped")
    }
    
    @objc func playButtonTapped(sender: UIButton!) {
        print("TEST: Play Button Tapped")
    }
}
