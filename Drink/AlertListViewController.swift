//
//  AlertListViewController.swift
//  Drink
//
//  Created by 이동희 on 2022/02/07.
//

import UIKit

class AlertListViewController: UITableViewController {
    
    //tabieView에 뿌려질 Alert
    var alerts: [Alert] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add alert switch
        let nibName = UINib(nibName: "AlertListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AlertListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        alerts = alertList()
    }
    
    @IBAction func addAlertButtonAction(_ sender: UIBarButtonItem) {
        guard let addAlertVC = storyboard?.instantiateViewController(withIdentifier: "AddAlertViewController") as? AddAlertViewController else { return }
        //생성된 Alert이 List에 표현되도록 구현
        addAlertVC.pickedDate = { [weak self] date in
            guard let self = self else { return }
            //Alert 받기
            var alertList = self.alertList()
            let newAlert = Alert(date: date, isOn: true)
            
            alertList.append(newAlert)
            alertList.sort { $0.date < $1.date } //time sorting
            
            self.alerts = alertList
            
            //여기선 인코딩
            UserDefaults.standard.set( try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            
            self.tableView.reloadData()
        }
        self.present(addAlertVC, animated: true, completion: nil)
    }
    
    //UserDefaults로 Value 저장 - 각 Cell별로 isOn의 상태를 TableView가 알수있도록
    func alertList() -> [Alert] {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              //UD는 임의로 만든 구조체를 이해하지 못하기 때문에 인코딩, 디코딩을 하여 익숙한 객체로 만들수 있음
              let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return []}
        return alerts
    }
    
}

//set UITableView dataSource & delegate function
extension AlertListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
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
        
        cell.alertSwitch.isOn = alerts[indexPath.row].isOn
        cell.timeLabel.text = alerts[indexPath.row].time
        cell.meridiemLabel.text = alerts[indexPath.row].meridiem
        
        //Switch의 On/Off되는 상태를 반영 -> cellforRowAt에서 tag값 부여
        cell.alertSwitch.tag = indexPath.row
        
        return cell
    }
    
    //Setting the height of the cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //delete alert
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            //dev notification deleting
            self.alerts.remove(at: indexPath.row)
            UserDefaults.standard.set( try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            self.tableView.reloadData()
            return 
        default:
            break
        }
    }
    
}
