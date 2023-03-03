//
//  WeatherCurrentViewModel.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/2/23.
//

import Foundation

class WeatherForecastViewModel:ObservableObject{
    
    private var webservice: Webservice!
    
    
    init() {
        self.webservice = Webservice()
    }
    
     func fetchForcastWeather(city: String){
        webservice.getForcastWeather(city: city) { weathers in
            if let weathers = weathers{
                for i in weathers{
                    print(i.tempp)
                }

            }
        }
    }

    

}
