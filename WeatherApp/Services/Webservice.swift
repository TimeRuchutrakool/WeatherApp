//
//  Webservice.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/2/23.
//

import Foundation

struct Webservice{
    
    func getForcastWeather(city: String, completion: @escaping (([WeatherForecastModel]?) -> Void)){
        
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
                for i in list{
                    let dt = NSDate(timeIntervalSince1970: i.dt) as Date
                    let temp = i.main.temp
                    let icon = i.weather[0].icon
                    let weatherItem = WeatherForecastModel(dt: dt, temp: temp, icon: icon)
                    weatherArray.append(weatherItem)
                }
                DispatchQueue.main.async {
                    completion(weatherArray)
                }
                
            }catch{
                print(error)
            }
        }.resume()
    }
    
}

