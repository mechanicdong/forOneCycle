//
//  ViewController.swift
//  pomodoro
//
//  Created by 이동희 on 2022/01/10.
//

import UIKit

enum TimerStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {

    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var toggleButton: UIButton!
    
    //Timer 설정된 시간을 초로 저장하는 프로퍼티
    var duration = 60
    //Timer의 상태를 가진 프로퍼티
    var timerStatus: TimerStatus = .end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
    }
    
    func setTimerInfoViewVisible(isHidden : Bool) {
        self.timerLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
    }
    
    //상태에 따라 확인 버튼의 명칭이 변경되도록 하는 메서드
    func configureToggleButton() {
        self.toggleButton.setTitle("시작", for: .normal) //초기상태
        self.toggleButton.setTitle("일시정지", for: .selected) //선택된 상태
    }

    @IBAction func tabCancelButton(_ sender: UIButton) {
        switch self.timerStatus {
        case .start, .pause:
            self.timerStatus = .end
            self.cancelButton.isEnabled = false
            self.setTimerInfoViewVisible(isHidden: true)
            self.datePicker.isHidden = false 
            self.toggleButton.isSelected = false //toggleButton의 Title이 "시작"이 되도록
            
        default:
            break
        }
    }
    
    @IBAction func tabToggleButton(_ sender: UIButton) {
        self.duration = Int(self.datePicker.countDownDuration)
        // countDownDuration : datePicker에서 선택한 시간을 '초'로 가져올 수 있음. 2분 설정 -> 120초
        switch self.timerStatus {
        case .end :
            self.timerStatus = .start
            self.setTimerInfoViewVisible(isHidden: false) //timerLabel & progressView가 표시되도록
            self.datePicker.isHidden = true
            self.toggleButton.isSelected = true
            self.cancelButton.isEnabled = true //취소버튼 활성화
        case .start :
            self.timerStatus = .pause
            self.toggleButton.isSelected = false
            
        case .pause :
            self.timerStatus = .start
            self.toggleButton.isSelected = true
        }
        
        
    }
}

