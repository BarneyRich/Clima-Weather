//
//  ViewController.swift
//  Clima-Weather
//
//  Created by Barnabas Bala on 01.02.2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageview: UIImageView!
    @IBOutlet weak var temperatureLable: UILabel!
    @IBOutlet weak var cityLable: UILabel!
    
    var weatherManager = WeatherManager()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
            searchTextField.delegate = self
    }


    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        //print(searchTextField.text!)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        //print(searchTextField.text!)
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type a city name"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use searchTextField.text to get the weather for that city
        
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    
}

 
