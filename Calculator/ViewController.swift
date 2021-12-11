//
//  ViewController.swift
//  Calculator
//
//  Created by 이동희 on 2021/12/08.
//

import UIKit

enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}
class ViewController: UIViewController {

    @IBOutlet weak var stackedOutputLabel: UILabel!
    @IBOutlet weak var numberOutputLabel: UILabel!
    //계산기 버튼을 누를 때마다 넘버아웃풋라벨에 표시되는 숫자를 가지고 있는 프로퍼티
    var displayNumber = ""
    //이전 계산값을 저장하는 프로퍼티
    var firstOperand  = ""
    //새롭게 입력된 값을 저장하는 프로퍼티
    var secondOperand = ""
    //계산의 결과값 저장
    var result = ""
    //현재 계산기에 어떤 연산자가 입력되었는지 알수있게 연산자의 값을 저장
    var currentOperation : Operation = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func tabNumberButton(_ sender: UIButton) {
        guard let numberValue =  sender.title(for: .normal) else {return}
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = self.displayNumber
            self.stackedOutputLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tabClearButton(_ sender: UIButton) {
        //초기화버튼 -> 모든 프로퍼티를 초기값으로 초기화
        //넘버아웃풋라벨 텍스트에 0이 표시되도록
        self.displayNumber = ""
        self.firstOperand  = ""
        self.secondOperand = ""
        self.result        = ""
        self.currentOperation = .unknown
        self.numberOutputLabel.text = "0"
        //label로 현재 진행상황 모니터링 20211209@LDH
        self.stackedOutputLabel.text = "0"
    }
    
    @IBAction func tabDotButton(_ sender: UIButton) {
        //소수점포함 9자리까지 포함되게 예외처리를 해야함
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = self.displayNumber
            self.stackedOutputLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tabDivideButton(_ sender: UIButton) {
        self.operation(.Divide)
    }
    
    @IBAction func tabMultiplyButton(_ sender: UIButton) {
        self.operation(.Multiply)
    }
    
    @IBAction func tabSubtractButton(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    
    @IBAction func tabAddButton(_ sender: UIButton) {
        self.operation(.Add)
    }
    
    @IBAction func tabEqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    //계산을 담당하는 함수 선언
    func operation(_ operation: Operation){
        if self.currentOperation != .unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
                guard let firstOperand = Double(self.firstOperand) else {return}
                guard let secondOperand = Double(self.secondOperand) else {return}
                
                switch self.currentOperation {
                case .Add :
                    self.result = "\(firstOperand + secondOperand)"
                case .Subtract :
                    self.result = "\(firstOperand - secondOperand)"
                case .Divide :
                    self.result = "\(firstOperand / secondOperand)"
                case .Multiply :
                    self.result = "\(firstOperand * secondOperand)"
                default :
                    break
                }
                //소수점뒤에 0이오는 경우는 0이 필요없으므로 정수처리
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                self.firstOperand = self.result
                self.numberOutputLabel.text = self.result
                
            }
            self.currentOperation = operation
        } else {
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            //첫번째 숫자를 누르고 다음 숫자를 누르면 그 숫자가 표시되어야 하기 때문에 초기화
            self.displayNumber = ""
            
        }
    }
    
}

