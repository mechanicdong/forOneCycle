//
//  ProfileViewController.swift
//  Instagram
//
//  Created by 이동희 on 2022/03/23.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40.0
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
                
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요."
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.numberOfLines = 0 //최대 줄 수 없음
        
        return label
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 3.0
        
        return button
    }()
    
    private lazy var messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 3.0
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.quaternaryLabel.cgColor //연한 회색
    
        return button
    }()
    
    private let photoDataView = ProfileDataView(title: "게시물", count: 123)
    private let followerDataView = ProfileDataView(title: "팔로워", count: 11111)
    private let followingDataView = ProfileDataView(title: "팔로잉", count: 59)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupLayout()
    }
    
}

extension ProfileViewController {
    
    func setupNavigationBar() {
        navigationItem.title = "UserName"
        let settingButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: nil)
        navigationItem.rightBarButtonItem = settingButton
    }
    
    func setupLayout() {
        let buttonStackView = UIStackView(
            arrangedSubviews: [followButton, messageButton]
        )
        buttonStackView.spacing = 4.0
        buttonStackView.distribution = .fillEqually //set width
        
        let dataStackView = UIStackView(
            arrangedSubviews: [ photoDataView, followerDataView, followingDataView]
        )
        dataStackView.spacing = 4.0
        dataStackView.distribution = .fillEqually
        
        [
            profileImageView,
            dataStackView,
            nameLabel,
            descriptionLabel,
            buttonStackView,
        ].forEach {
            view.addSubview($0)
        }
        
        let inset: CGFloat = 16.0 //반복사용 높기때문에 상수설정
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset) //네비게이션 타이틀바의 safeArea
            $0.leading.equalToSuperview().inset(inset)
            $0.width.equalTo(80.0)
            $0.height.equalTo(profileImageView.snp.width)
        }
        
        dataStackView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.centerY.equalTo(profileImageView.snp.centerY) //중앙정렬
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(12.0)
            $0.leading.equalTo(profileImageView.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12.0)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
        
    }
}
