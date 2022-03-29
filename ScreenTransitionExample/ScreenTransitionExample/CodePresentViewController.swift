//
//  CodePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by 이동희 on 2021/12/04.
//

import UIKit

/*delegate pattern을 활용하여 이전화면에 데이터를 전달하는 방법
 우선 Protocol 정의(SendDataDelegate)하고 AnyObject 상속받음
 또한 delegate 변수를 정의할 때는 weak라는 키워드를 붙여줘야 함,
 안붙여주면 강한 참조가 걸려 메모리누수가 발생하게 됨
 */
protocol SendDataDelegate: AnyObject {
    func sendData(name : String)
}

class CodePresentViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    var name : String?
    weak var delegate : SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
    }
    
    @IBAction func tabBackButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "Gunter")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

    
}
