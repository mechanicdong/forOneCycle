//
//  HomeViewController.swift
//  NetFlixStyleApp
//
//  Created by 이동희 on 2022/02/13.
//

//Snapkit을 사용하여 storyboard 없이 Code로 구현

import UIKit

class HomeViewController: UICollectionViewController {
    var contents: [Content] = []
    
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
        
        //set data & reading data
        contents = getContents()
    }
    
    func getContents() -> [Content] {
        //Content plist의 경로를 가져오는 변수
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else { return []}
        
        return list
    }
}

//UICollectionView DataSource, Delegate
extension HomeViewController {
    //Section당 보여지는 Cell의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return contents[section].contentItem.count
        }
    }
    
    //Set CollectionView Cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    //섹션 개수 설정
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    //cell 선택을 감지하는 delegate 설정
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("TEST: \(sectionName) 섹션의 \(indexPath.row + 1)번째 컨텐츠")
    }
}
