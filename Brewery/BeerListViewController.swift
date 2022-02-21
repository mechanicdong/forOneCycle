//
//  BeerListViewController.swift
//  Brewery
//
//  Created by 이동희 on 2022/02/21.
//

import UIKit

class BeerListViewController: UITableViewController {
    //UITableView's datasource setting
    var beerList = [Beer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation setting
        //1. UINavigationBar
        title = "브루어리"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//UITableView's datasource, delegate setting
extension BeerListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count //각각의 row 값은 맥주의 개수이므로
    }
}
