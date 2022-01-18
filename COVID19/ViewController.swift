//
//  ViewController.swift
//  COVID19
//
//  Created by 이동희 on 2022/01/16.
//

import UIKit
import Charts //for PieChartView

class ViewController: UIViewController {

    @IBOutlet var totalCaseLabel: UILabel!
    @IBOutlet var newCaseLabel: UILabel!
    @IBOutlet var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

