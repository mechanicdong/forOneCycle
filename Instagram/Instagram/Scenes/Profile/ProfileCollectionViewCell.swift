//
//  ProfileCollectionViewCell.swift
//  Instagram
//
//  Created by 이동희 on 2022/03/24.
//

import UIKit
import SnapKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    func setup(with image: UIImage) {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageView.backgroundColor = .tertiaryLabel
    }
}
