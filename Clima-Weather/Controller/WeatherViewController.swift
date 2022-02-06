//
//  ViewController.swift
//  Clima-Weather
//
//  Created by Barnabas Bala on 01.02.2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageview: UIImageView!
    @IBOutlet weak var temperatureLable: UILabel!
    @IBOutlet weak var cityLable: UILabel!

    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
            
            
            weatherManager.deleate = self
            searchTextField.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: Any) {
        locationManager.requestLocation()
        
    }
    
}

//MARK: - UITextFieldDelegate
 
extension WeatherViewController: UITextFieldDelegate {
    
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

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLable.text = weather.temperatureString
            self.conditionImageview.image = UIImage(systemName:  weather.conditionName)
            self.cityLable.text = weather.cityName
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            print(lat)
            print(lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
}
