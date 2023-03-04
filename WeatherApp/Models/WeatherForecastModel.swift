//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/2/23.
//

import Foundation

struct WeatherForecastModel{
    
    let dt: Date?
    let temp: Double?
    let icon: String?
    
    var temperatureInString: String?{
        return String(format: "%.0f°C", temp!)
    }
}
