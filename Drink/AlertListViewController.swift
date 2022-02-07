//
//  AlertListViewController.swift
//  Drink
//
//  Created by 이동희 on 2022/02/07.
//

import UIKit

class AlertListViewController: UITableViewController {
    
    //tabieView에 뿌려질 Alert
    var alertList: [Alert] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add alert switch
        let nibName = UINib(nibName: "AlertListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AlertListCell")
    }
    
    @IBAction func addAlertButtonAction(_ sender: UIBarButtonItem) {
    }
     
}

//set UITableView dataSource & delegate function
extension AlertListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertList.count
    }
    //Section을 나눠 헤더를 표현
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "⽔ 마실 시간"
        default:
            return nil
        }
    }
    //AlertListCell nib에 data 전달
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertListCell", for: indexPath) as? AlertListCell else { return UITableViewCell() }
        
        cell.alertSwitch.isOn = alertList[indexPath.row].isOn
        cell.timeLabel.text = alertList[indexPath.row].time
        cell.meridiemLabel.text = alertList[indexPath.row].meridiem
        
        return cell
    }
    
    //Setting the height of the cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
