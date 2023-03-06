//
//  Webservice.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/2/23.
//

import Foundation

struct Webservice{
    
    
    func getCurrentWeather(city: String, units: String ,completion: @escaping ((WeatherCurrentModel?) -> Void)){
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Constant.AppID)&units=\(units)") else{
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else{
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let decodedData = try JSONDecoder().decode(WeatherCurrentData.self, from: data)
                let dt = NSDate(timeIntervalSince1970: decodedData.dt) as Date
                let icon = decodedData.weather[0].icon
                let description = decodedData.weather[0].description
                let temp = decodedData.main.temp
                let humidity = decodedData.main.humidity
                let currentWeather = WeatherCurrentModel(dt: dt, icon: icon, description: description, temp: temp, humidity: humidity)
                
                DispatchQueue.main.async {
                    completion(currentWeather)
                }
                
            }catch{
                print(error)
            }
        }.resume()
        
        
    }
    
    func getForcastWeather(city: String, completion: @escaping (([Date : [WeatherForecastModel]]?) -> Void)){
        
        var weatherArray = [WeatherForecastModel]()
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(Constant.AppID)&units=metric") else{
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else{
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do{
                let decodedData = try JSONDecoder().decode(WeatherForcastData.self, from: data)
                let list = decodedData.list
                let dateNow = Calendar.current.dateComponents([.year, .month,.day], from: Date())
                //print(dateNow)
                for i in list{
                    
                    let dt = NSDate(timeIntervalSince1970: i.dt) as Date
                    let dtComponent = Calendar.current.dateComponents([.year, .month,.day], from: dt)
                    if dtComponent != dateNow{
                        let temp = i.main.temp
                        let icon = i.weather[0].icon
                        let weatherItem = WeatherForecastModel(id: dt, dt: dt, temp: temp, icon: icon)
                        weatherArray.append(weatherItem)
                    }
                    
                }
                for i in weatherArray{
                    print(i.dt)
                }
                
                let groupedWeather = groupByDate(weatherArray: weatherArray)
                
                
                DispatchQueue.main.async {
                    completion(groupedWeather)
                }
                
            }catch{
                print(error)
            }
        }.resume()
    }
    
    func groupByDate(weatherArray: [WeatherForecastModel]) -> [Date: [WeatherForecastModel]] {
        let preGroupDate: [Date: [WeatherForecastModel]] = [:]
        let groupedByDate = weatherArray.reduce(into: preGroupDate) { accumulateValue, currentValue in
            let components = Calendar.current.dateComponents([.year, .month,.day], from: currentValue.dt!)
            let date = Calendar.current.date(from: components)!
            let existing = accumulateValue[date] ?? []
            accumulateValue[date] = existing + [currentValue]
        }
        
        return groupedByDate
    }


    
}

