//
//  AddAlertViewController.swift
//  Drink
//
//  Created by 이동희 on 2022/02/08.
//

import UIKit

class AddAlertViewController: UIViewController  {
    var pickedDate: ((_ date: Date) -> Void)?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        //설정한 시간값을 부모뷰에 전달 - 여기선 클로저 사용
        pickedDate?(datePicker.date)
        self.dismiss(animated: true, completion: nil)        
    }
}
