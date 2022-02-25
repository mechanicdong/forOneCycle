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
    //Reading data from URL based on Page
    var currentPage = 1
    //데이터를 중복으로 불러옴을 방지하는 변수
    var dataTasks = [URLSessionDataTask]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation setting
        //1. UINavigationBar
        title = "브루어리"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Set UITableView
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 150 //static하게 높이 설정
        
        //Pagination(1 페이지에서 다음 페이지의 beer load를 위해), extension에도 UITableViewDataSourcePrefetching
        tableView.prefetchDataSource = self
        fetchBeer(of: currentPage)
        
    }
}

//UITableView's datasource, delegate setting
extension BeerListViewController: UITableViewDataSourcePrefetching {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailViewController = BeerDetailViewController()
        
        detailViewController.beer = selectedBeer
        self.show(detailViewController, sender: nil)
    }
    
    //prefetchRowsAt setting: executed after first page loading
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else { return }
        
        indexPaths.forEach {
            if ($0.row + 1)/25 + 1 == currentPage {
                self.fetchBeer(of: currentPage)
            }
        }
    }
    
}

//Data fetching
private extension BeerListViewController {
    func fetchBeer(of page: Int) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
              dataTasks.firstIndex(where: { task in
                  task.originalRequest?.url == url //새롭게 요청된 URL이 함수안에 들어온 url에 없어야함(새로운 값이어야만)
              }) == nil
            else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //DataTask setting
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                      print("ERROR: URLSession Data Task \(error?.localizedDescription ?? "")")
                      return
                  }
            switch response.statusCode {
            case (200...299): //success
                self.beerList += beers
                self.currentPage += 1
                
                DispatchQueue.main.async { //비동기 처리
                    self.tableView.reloadData()
                }
            case (400...499): //client error
                print("""
                    ERROR: Client Error \(response.statusCode)
                    Response: \(response)
                """)
            case (500...599): //server error
                print("""
                    ERROR: Server Error \(response.statusCode)
                    Response: \(response)
                """)
            default:
                print("""
                    ERROR: \(response.statusCode)
                    Response: \(response)
                """)
            }
        }
        dataTask.resume() //반드시 dataTask 실행
        dataTasks.append(dataTask) //Page 중복 읽어오기 방지
    }
}
