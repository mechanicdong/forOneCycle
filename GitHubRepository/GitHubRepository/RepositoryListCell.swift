//
//  RepositoryListCell.swift
//  GitHubRepository
//
//  Created by 이동희 on 2022/04/01.
//

import UIKit
import SnapKit

class RepositoryListCell: UITableViewCell {
    var repository: String?
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let starImageView = UIImageView()
    let starLabel = UILabel()
    let languageLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [
            nameLabel, descriptionLabel,
            starImageView, starLabel,
            languageLabel
        ].forEach {
            addSubview($0) //contentView.addSubview와의 차이점?
        }
    }
}
