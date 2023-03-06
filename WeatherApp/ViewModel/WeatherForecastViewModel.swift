//
//  WeatherCurrentViewModel.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/2/23.
//

import Foundation

class WeatherForecastViewModel:ObservableObject{
    
    private var webservice: Webservice!
    @Published var forecastWeather: [Date: [WeatherForecastModel]]
    
    init() {
        self.webservice = Webservice()
        forecastWeather = [:]
    }
    
     func fetchForcastWeather(city: String){
         
         webservice.getForcastWeather(city: city) { weathers in
             if let weathers = weathers{
                 
                 self.forecastWeather = weathers
               
                 
             }
        }
    }

    

}


