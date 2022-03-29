//
//  BeerDetailViewController.swift
//  Brewery
//
//  Created by 이동희 on 2022/02/22.
//

import UIKit
import SnapKit
import Kingfisher

class BeerDetailViewController: UITableViewController {
    var beer: Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = beer?.name ?? "이름 없는 맥주 !"
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        //여기서 tableView는 다른 custom한 cell을 만들지 않고 등록
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BeerDetailListCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        //create HeaderView = 상단 ImageView
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        let headerView = UIImageView(frame: frame)
        let imageURL = URL(string: beer?.imageURL ?? "")
        
        //headerview setting
        headerView.contentMode = .scaleAspectFit
        headerView.kf.setImage(with: imageURL, placeholder: UIImage(named: "beer_icon"))
        
        //customed tableView's headerview setting
        tableView.tableHeaderView = headerView
    }
}

//UITableView DataSource, Delegate
extension BeerDetailViewController {
    //count of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    //count of row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section { //section별로 row 개수 다름
        case 3: //foodpairing
            return beer?.foodPairing?.count ?? 0
        default:
            return 1
        }
    }
    
    //title for header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "ID"
        case 1:
            return "Description"
        case 2:
            return "Brewers Tips"
        case 3: //if there is not foodpairing, then
            let isFoodPairingEmpty = beer?.foodPairing?.isEmpty ?? true
            return isFoodPairingEmpty ? nil : "Food Paring"
        default:
            return nil
        }
    }
    
    //Cell setting
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "BeerDetailListCell")
        
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none //Tap할 시 회색이 표시되지 않도록
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = String(describing: beer?.id ?? 0)
            return cell
        case 1:
            cell.textLabel?.text = beer?.description ?? "설명 없는 맥주"
            return cell
        case 2:
            cell.textLabel?.text = beer?.brewersTips ?? "팁 없는 맥주"
            return cell
        case 3:
            cell.textLabel?.text = beer?.foodPairing?[indexPath.row] ?? ""
            return cell
        default:
            return cell
        }
    }
}
