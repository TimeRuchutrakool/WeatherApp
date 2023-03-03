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
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable{

    let icon: String
}


