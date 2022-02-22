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
        
        //Set UITableView
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 150 //static하게 높이 설정
    }
}

//UITableView's datasource, delegate setting
extension BeerListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count //각각의 row 값은 맥주의 개수이므로
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCell else { return UITableViewCell() }
        //맥주를 configure fucn에 넣어주기
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        
        return cell
    }
}
