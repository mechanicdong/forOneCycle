//
//  HomeViewController.swift
//  NetFlixStyleApp
//
//  Created by 이동희 on 2022/02/13.
//

//Snapkit을 사용하여 storyboard 없이 Code로 구현

import UIKit

class HomeViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Navigation
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        //add button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(imageLiteralResourceName: "netflix_icon"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
    }
}
