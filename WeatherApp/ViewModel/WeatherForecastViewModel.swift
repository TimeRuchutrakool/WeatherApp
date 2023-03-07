//
//  WeatherCurrentViewModel.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/2/23.
//

import Foundation

class WeatherForecastViewModel:ObservableObject{
    
    private var webservice: Webservice!
    @Published var forecastWeather: [Date: [ForecastModel]]
    
    init() {
        self.webservice = Webservice()
        forecastWeather = [:]
    }
    
    func fetchForcastWeather(city: String){
        
        webservice.getForcastWeather(city: city) { weathers in
            if let weathers = weathers{
                self.forecastWeather = self.groupByDate(weatherArray: weathers.map(ForecastModel.init))
            }
        }
    }
    
    func groupByDate(weatherArray: [ForecastModel]) -> [Date: [ForecastModel]] {
        let preGroupDate: [Date: [ForecastModel]] = [:]
        let groupedByDate = weatherArray.reduce(into: preGroupDate) { accumulateValue, currentValue in
            let components = Calendar.current.dateComponents([.year, .month,.day], from: currentValue.dt)
            let date = Calendar.current.date(from: components)!
            let existing = accumulateValue[date] ?? []
            accumulateValue[date] = existing + [currentValue]
        }
        
        return groupedByDate
    }
    
    
    
}

struct ForecastModel{
    let forecastWeather: WeatherForecastModel
    
    var dt: Date{
        return forecastWeather.dt!
    }
    
    var date: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: forecastWeather.dt!)
    }
    var temperature: String{
        return String(format: "%.0f°C", forecastWeather.temp!)
    }
    var icon:String{
        return forecastWeather.icon!
    }
}
