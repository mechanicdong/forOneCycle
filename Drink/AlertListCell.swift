//
//  AlertListCell.swift
//  Drink
//
//  Created by 이동희 on 2022/02/07.
//

import UIKit

class AlertListCell: UITableViewCell {
    @IBOutlet weak var meridiemLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alertSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func alertSwitchValueChanged(_ sender: UISwitch) {
    }
    
}
