//
//  WeatherCurrentView.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/3/23.
//

import SwiftUI
import URLImage
import UIKit

struct WeatherCurrentView: View {
    
    @ObservedObject var weatherCurrentVM: WeatherCurrentViewModel
    @State var convertUnits: Bool = false

    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        weatherCurrentVM = WeatherCurrentViewModel()
        weatherCurrentVM.fetchCurrentWeather(city: "bangkok", units: "metric")
    }
    
    var body: some View {
        
        NavigationView{
            ZStack{//Z1
                GeometryReader{ geometry in
                    Image("background")
                        .resizable()
                        .aspectRatio(geometry.size,contentMode: .fill)
                        .ignoresSafeArea()
                        
                    VStack{//V1
                        CityTextField(cityName: $weatherCurrentVM.cityName,search: weatherCurrentVM.search)
                        Spacer()
                            .frame(height: UIScreen.main.bounds.height*0.1)
                        CityLabelAndConvertButton(cityName: weatherCurrentVM.cityName,search: weatherCurrentVM.search,convertUnits: $weatherCurrentVM.convertUnits)
                        
                        
                        Text(weatherCurrentVM.temperatureInString)
                            .font(.custom("Arial", size: 90))
                            .bold()
                            .foregroundColor(.white)
                        
                        
                        Text(weatherCurrentVM.date)
                            .font(.custom("Arial", size: 20))
                            .foregroundColor(.white)
                        Spacer()
                            .frame(height: 50)
                        HumidityAndWeatherImage(humidityInString: weatherCurrentVM.humidityInString,imageName: weatherCurrentVM.icon,description: weatherCurrentVM.description)
                        Spacer()
                            .frame(height: 30)
                        
                        ForecastWeatherButton(city: weatherCurrentVM.cityName)
                        
                    }//V1
                }
                .navigationTitle("Weather")
                
            }//Z1
        }
        .accentColor(.white)
    }
    
    struct WeatherCurrentView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherCurrentView()
        }
    }
}

struct CityTextField: View {
    @Binding var cityName: String
    var search: () -> ()
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(.purple).opacity(0.4)
            TextField("Search", text: $cityName){
                search()
            }.foregroundColor(.black)
            
        }
        .padding()
        .background(.white)
        .cornerRadius(30)
        .padding(-5)
        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.purple,lineWidth: 2).opacity(0.4))
        .shadow(radius: 7)
        .frame(width: UIScreen.main.bounds.width*0.8)
        .padding(25)
        
    }
}

struct CityLabelAndConvertButton: View {
    var cityName: String
    var search: () -> ()
    @Binding var convertUnits: Bool
    var body: some View {
        HStack{//H1
            Text(cityName)
                .font(.custom("Arial", size: 20))
                .bold()
                .foregroundColor(.white)
            Button (action: {
                convertUnits.toggle()
                search()
            }) {
                HStack{
                    
                    Image(systemName: "repeat")
                        .offset(x:8)
                    Text(convertUnits ? "To Celsius": "To Farenheit")
                }.foregroundColor(.white)
            }
        }
    }
}

struct HumidityAndWeatherImage: View {
    var humidityInString: String
    var imageName: String
    var description: String
    var body: some View {
        HStack{//H3
            Spacer()
            VStack{
                Image(systemName: "humidity.fill")
                    .resizable()
                    .frame(width: 35,height: 30)
                Text(humidityInString)
                    .font(.custom("Arial", size: 17))
                Text("Humidity")
                    .font(.custom("Arial", size: 18))
            }.foregroundColor(.white)
                .offset(x:30)
            Spacer()
                .frame(width: 70)
            VStack{
                ZStack {
                    Circle()
                        .fill(Color(red: 128/255, green: 121/255, blue: 203/255))
                        .frame(width: 100,height: 100)
                        .shadow(color: Color(red: 165/255, green: 117/255, blue: 202/255), radius: 10,x: -10,y: -10)
                        .shadow(color: Color(red: 123/255, green: 121/255, blue: 204/255), radius: 10,x: 10,y: 10)
                        
                    URLImage(URL(string: "https://openweathermap.org/img/wn/\(imageName)@2x.png")!) { image, info in
                        image.resizable()
                            .frame(width: 100,height: 100)
                            .shadow(radius: 10,x: 15,y: 15)
                    }
                }
                
                Text(description)
            }
            .foregroundColor(.white)
            Spacer()
        }
    }
}

struct ForecastWeatherButton: View {
    var city: String
    var body: some View {
        NavigationLink(destination: WeatherForecastView(cityName: city)){
            Text("Forecast Weather")
                .font(.custom("Arial", size: 17))
                .bold()
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width*0.6,height: 50)
                .background(Color(red: 218/255, green: 118/255, blue: 204/255))
                .cornerRadius(30)
        }
    }
}
