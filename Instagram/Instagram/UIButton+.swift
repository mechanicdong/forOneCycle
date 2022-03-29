//
//  UIButton+.swift
//  Instagram
//
//  Created by 이동희 on 2022/03/23.
//

import UIKit

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
