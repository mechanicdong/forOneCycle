//
//  MovieViewController.swift
//  NetFlixStyleApp
//
//  Created by 이동희 on 2022/02/20.
//

import UIKit

class MovieViewController: UICollectionViewController {
    
    var contents: [Content] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Navigation
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        //add button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "〈", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .white
        
    }
    @objc private func backButtonTapped(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
}


