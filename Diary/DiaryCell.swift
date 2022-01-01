//
//  DiaryCell.swift
//  Diary
//
//  Created by 이동희 on 2021/12/26.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!
    
    //Cell 테두리 생성
    //init? 생성자 정의 : UIView가 스토리보드에서 생성될 때 이 객체를 통해 생성됨
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
