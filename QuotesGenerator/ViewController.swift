//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by 이동희 on 2021/12/03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    let quotes = [
        Quote(contents: "명언 1", name: "가보자"),
        Quote(contents: "명언 2", name: "이동희"),
        Quote(contents: "명언 3", name: "스위프트"),
        Quote(contents: "명언 4", name: "개발자"),
        Quote(contents: "명언 5", name: "도전")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func tabQuoteGeneratorButton(_ sender: Any) {
        //랜덤 숫자 구하기
        let random = Int(arc4random_uniform(5)) // 0~4 사 이의 난수를 랜덤하게 생성 -> Int로 치환
        let quote = quotes[random]
        self.quoteLabel.text = quote.contents
        self.nameLabel.text  = quote.name
        
    }

}

