//
//  WeatherManager.swift
//  Clima-Weather
//
//  Created by Barnabas Bala on 01.02.2022.
//

import Foundation


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c93f8c933258081e95fca4082a50632b&units=metric"
    
    
    func fetchWeather(cityName:String) {
       
        let urlString = "\(weatherURL)&q=\(cityName)"
       performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        
        //Create a URLSession
        
        if let url = URL(string: urlString) {
            
            //Create a URLSession
            
            let session = URLSession(configuration: .default)
            
            //Give the session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData:safeData)
                    
                }
            }
            
            //Start the task
            
            task.resume()
        }
    }
    func parseJSON(weatherData:Data) {
        let decoder = JSONDecoder()
        do {
         let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch {
            print (error)
        }
        
    }
}
