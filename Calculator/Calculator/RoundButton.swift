//
//  RoundButton.swift
//  Calculator
//
//  Created by 이동희 on 2021/12/08.
//

import UIKit

@IBDesignable //변경된 설정값을 스토리보드에서 실시간으로 확인할 수 있게 
class RoundButton: UIButton {
    // isRound 라는 property 선언, 초기값 False
    // 연산 프로퍼티가 되도록 -> didSet
    //IBInspectable : StoryBoard에서도 isRound 프로퍼티 설정값을 변경시킬 수 있게
    @IBInspectable var isRound : Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
