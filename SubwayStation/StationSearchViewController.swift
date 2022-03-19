//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by 이동희 on 2022/03/19.
//

import UIKit
import SnapKit

class StationSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철역을 입력해주세요"
        searchController.obscuresBackgroundDuringPresentation = false // TODO
        
        navigationItem.searchController = searchController
    }


}

