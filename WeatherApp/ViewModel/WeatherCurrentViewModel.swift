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
    
    init() {
        self.webservice = Webservice()
        currentWeather = WeatherCurrentModel(dt: nil, icon: nil, description: nil, temp: nil, humidity: nil)
    }
    
    func search(){
        if let city = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            fetchCurrentWeather(city: city, units: "metric")
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
