//
//  WeatherCurrentViewModel.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/3/23.
//

import Foundation

class WeatherCurrentViewModel: ObservableObject{
    
    private var webservice: Webservice!
    @Published var currentWeather: WeatherCurrentModel
    var cityName: String = "Bangkok"
    var convertUnits: Bool = false
    
    init() {
        self.webservice = Webservice()
        currentWeather = WeatherCurrentModel(dt: nil, icon: nil, description: nil, temp: nil, humidity: nil)
    }
    
    func search(){
        if let city = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            fetchCurrentWeather(city: city, units: convertUnits ? "imperial" : "metric")
        }
    }
    
    func fetchCurrentWeather(city: String, units: String){
        
        webservice.getCurrentWeather(city: city,units: units) { weather in
            
            if let weather = weather{
                self.currentWeather = weather
            }
            
        }
        
    }
    
    
    
}
extension WeatherCurrentViewModel{
    var temperatureInString: String{
        if let temp = currentWeather.temp{
            if convertUnits{
                return String(format: "%.0f°F", temp)
            }
            else{
                return String(format: "%.0f°C", temp)
            }
            
        }else{
            return ""
        }
        
    }
    var humidityInString: String{
        if let humidity = currentWeather.humidity{
            return "\(humidity)%"
            
        }else{
            return ""
        }
    }
    
    var date: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y"
        if let date = currentWeather.dt{
            return formatter.string(from: date)
            
        }else{
            return ""
        }
    }
    var icon: String{
        if let icon = currentWeather.icon{
            return icon
        }
        else{
            return "01d"
        }
    }
    var description: String{
        if let description = currentWeather.description{
            return description
        }
        else{
            return ""
        }
    }
}
