//
//  ViewController.swift
//  Weather
//
//  Created by 이동희 on 2022/01/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityNameTextField: UITextField!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var weatherDescriptionLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func tapFetchWeatherButton(_ sender: UIButton) {
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true) //button이 눌리면 키보드가 사라지게
        }
    }
    
    func getCurrentWeather(cityName: String) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName) &appid=6ef24838143eb1b4d16156344f13bfec") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            //JSON Data는 data 파라미터로 전달
            guard let data = data, error == nil else { return } //정상일 때 error는 nil 반환
            let decoder = JSONDecoder() //JSON 객체에서 데이터 유형으로 디코딩하는 객체
            let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data)
        }.resume()
    }
}

