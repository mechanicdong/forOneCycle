//
//  FeedTableViewCell.swift
//  Instagram
//
//  Created by 이동희 on 2022/03/23.
//

import UIKit
import SnapKit

extension UIButton {
    //좋아요 버튼의 크기가 commentButton, DMButton과 맞지 않아 조정
    func setImage(systemName: String) {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        
        imageView?.contentMode = .scaleAspectFit
        //imageEdgeInsets = .zero //deprecated in iOS 15.0
        
        setImage(UIImage(systemName: systemName), for: .normal)
    }
}

final class FeedTableViewCell: UITableViewCell {
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiaryLabel
        
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let Button = UIButton()
        //Button.setImage(UIImage(systemName: "heart"), for: .normal)
        Button.setImage(systemName: "heart")
        return Button
    }()
    
    private lazy var commentButton: UIButton = {
        let Button = UIButton()
        //Button.setImage(UIImage(systemName: "message"), for: .normal)
        Button.setImage(systemName: "message")
        return Button
    }()
    
    private lazy var directMessageButton: UIButton = {
        let Button = UIButton()
        //Button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        Button.setImage(systemName: "paperplane")
        
        return Button
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let Button = UIButton()
        //Button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        Button.setImage(systemName: "bookmark")
        
        return Button
    }()
    
    private lazy var currentLikedCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.text = "이동희님 외 32명이 좋아합니다"
        
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.numberOfLines = 5
        label.text = "오늘의 갬성샷...라인 최대 표시는 5줄임..."
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 11.0, weight: .medium)
        label.text = "3일 전"
        
        return label
    }()
    
    func setup() {
        
        [
            postImageView,
            likeButton,
            commentButton,
            directMessageButton,
            bookmarkButton,
            currentLikedCountLabel,
            contentsLabel,
            dateLabel
        ].forEach { addSubview($0) }
        
        postImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(postImageView.snp.width)
        }

        let buttonWidth: CGFloat = 24.0
        let buttonInset: CGFloat = 16.0

        likeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(buttonInset)
            $0.top.equalTo(postImageView.snp.bottom).offset(buttonInset)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }

        let buttonSpacing: CGFloat = 12.0

        commentButton.snp.makeConstraints {
            $0.leading.equalTo(likeButton.snp.trailing).offset(buttonSpacing)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }

        directMessageButton.snp.makeConstraints {
            $0.leading.equalTo(commentButton.snp.trailing).offset(buttonSpacing)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }

        bookmarkButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(buttonInset)
            $0.top.equalTo(likeButton.snp.top)
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonWidth)
        }

        currentLikedCountLabel.snp.makeConstraints {
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(likeButton.snp.bottom).offset(14.0)
        }

        let labelVerticalSpacing: CGFloat = 8.0

        contentsLabel.snp.makeConstraints {
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(currentLikedCountLabel.snp.bottom).offset(labelVerticalSpacing)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookmarkButton.snp.trailing)
            $0.top.equalTo(contentsLabel.snp.bottom).offset(labelVerticalSpacing)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
}
