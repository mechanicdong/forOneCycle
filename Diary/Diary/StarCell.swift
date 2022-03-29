//
//  StarCell.swift
//  Diary
//
//  Created by 이동희 on 2021/12/26.
//

import UIKit

class StarCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    //즐겨찾기 셀의 테두리 구현
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
     
}
