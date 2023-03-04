//
//  WeatherCurrentData.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/3/23.
//

import Foundation

struct WeatherCurrentData: Decodable{
    
    let dt: Double
    let weather: [WeatherCurrent]
    let main: MainCurrent
}

struct WeatherCurrent: Decodable{
    
    let icon: String
    let description: String
    
}

struct MainCurrent: Decodable{
    
    let temp: Double
    let humidity: Int
    
}
