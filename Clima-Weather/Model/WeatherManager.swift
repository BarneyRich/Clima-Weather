//
//  WeatherManager.swift
//  Clima-Weather
//
//  Created by Barnabas Bala on 01.02.2022.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error:Error)
}


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c93f8c933258081e95fca4082a50632b&units=metric"
    
    var deleate: WeatherManagerDelegate?
    
    func fetchWeather(cityName:String) {
       
        let urlString = "\(weatherURL)&q=\(cityName)"
       performRequest(with: urlString)
        
    }
    
    
    func fetchWeather(latitude: CLLocationDegrees, longitude:CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
       performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        //Create a URLSession
        
        if let url = URL(string: urlString) {
            
            //Create a URLSession
            
            let session = URLSession(configuration: .default)
            
            //Give the session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.deleate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData:safeData) {
                        self.deleate?.didUpdateWeather(self, weather: weather)
                        
                    }
                    
                }
            }
            
            //Start the task
            
            task.resume()
        }
    }
    func parseJSON(weatherData:Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
         let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
           
        } catch {
            deleate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
   
}
