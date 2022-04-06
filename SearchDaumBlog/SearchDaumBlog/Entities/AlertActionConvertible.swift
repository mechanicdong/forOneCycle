//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by 이동희 on 2022/04/06.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
