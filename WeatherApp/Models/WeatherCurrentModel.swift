//
//  WeatherCurrentModel.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/3/23.
//

import Foundation

struct WeatherCurrentModel{
    
    let dt: Date?
    let icon: String?
    let description: String?
    let temp: Double?
    let humidity: Int?
    
    var temperatureInString: String{
        if let temp = temp{
            return String(format: "%.0f°C", temp)
            
        }else{
            return ""
        }
        
    }
    var humidityInString: String{
        if let humidity = humidity{
            return "\(humidity)%"
            
        }else{
            return ""
        }
    }
    
    var date: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y"
        if let date = dt{
            return formatter.string(from: date)
            
        }else{
            return ""
        }
    }
    
}

