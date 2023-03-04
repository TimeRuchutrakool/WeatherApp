//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/2/23.
//

import Foundation

struct WeatherForcastData: Decodable{
    
    let list: [List]
    
}

struct List: Decodable{
    let dt: Double
    let main: MainForecast
    let weather: [WeatherForecast]
}

struct MainForecast: Decodable{
    let temp: Double
}

struct WeatherForecast: Decodable{

    let icon: String
}


