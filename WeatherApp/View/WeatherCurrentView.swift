//
//  WeatherCurrentView.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/3/23.
//

import SwiftUI

struct WeatherCurrentView: View {
    
    @ObservedObject var weatherCurrentVM: WeatherCurrentViewModel
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        weatherCurrentVM = WeatherCurrentViewModel()
        weatherCurrentVM.fetchCurrentWeather(city: "bangkok", units: "metric")
    }
    
    var body: some View {
        
        NavigationView{
            ZStack{//Z1
                Image("background")
                    .edgesIgnoringSafeArea(.all)
                VStack{//V1
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $weatherCurrentVM.cityName)
                        
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(30)
                    .padding(-5)
                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.purple,lineWidth: 2))
                    .shadow(radius: 7)
                    .padding(25)
                    HStack{//H1
                        Text(weatherCurrentVM.cityName)
                            .font(.custom("Arial", size: 20))
                            .bold()
                            .foregroundColor(.white)
                        Button {
                            
                        } label: {
                            HStack{
                                Image(systemName: "repeat")
                                    .offset(x:8)
                                Text("To Farenheit")
                            }.foregroundColor(.white)
                        }
                    }//H1
                    Text(weatherCurrentVM.currentWeather.temperatureInString)
                        .font(.custom("Arial", size: 90))
                        .bold()
                        .foregroundColor(.white)
                    Text(weatherCurrentVM.currentWeather.date)
                        .font(.custom("Arial", size: 20))
                        .foregroundColor(.white)
                    Spacer()
                        .frame(height: 50)
                    HStack{//H3
                        VStack{
                            Image(systemName: "humidity.fill")
                                .resizable()
                                .frame(width: 35,height: 30)
                            Text(weatherCurrentVM.currentWeather.humidityInString)
                                .font(.custom("Arial", size: 17))
                            Text("Humidity")
                                .font(.custom("Arial", size: 18))
                        }.foregroundColor(.white)
                        Spacer()
                            .frame(width: 70)
                        VStack{
                            Image(systemName: "cloud.sun")
                                .resizable()
                                .frame(width: 45,height: 40)
                            Text("Cloudy")
                        }
                        .foregroundColor(.white)
                    }//H3
                    Button("Fetch") {
                        weatherCurrentVM.search()
                    }
                    
                }//V1
                
                .navigationTitle("Weather")
                
            }//Z1
        }
        
    }
    
    struct WeatherCurrentView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherCurrentView()
        }
    }
}
