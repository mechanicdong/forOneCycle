//
//  SeguePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by 이동희 on 2021/12/04.
//

import UIKit

/*Modal 형식이 꽉 찬 화면으로 하기 위해선 화살표의 Segue 오브젝트를 선택하여 속성 인스펙터 -> Presentaion : Full Screnn 설정
*/
class SeguePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tabBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
