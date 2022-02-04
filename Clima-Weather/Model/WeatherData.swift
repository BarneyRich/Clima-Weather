//
//  WeatherData.swift
//  Clima-Weather
//
//  Created by Barnabas Bala on 01.02.2022.
//

import Foundation

struct WeatherData: Decodable {
    let name:String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
