//
//  WeatherForecastView.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/4/23.
//

import SwiftUI
import URLImage

struct WeatherForecastView: View {
    
    var cityName: String
    @ObservedObject var weatherForecastVM: WeatherForecastViewModel
    let dateFormatter = DateFormatter()
    @Environment(\.dismiss) var dismiss
    init(cityName: String) {
        self.cityName = cityName
        self.weatherForecastVM = WeatherForecastViewModel()
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        dateFormatter.dateFormat = "hh:mm a"
        weatherForecastVM.fetchForcastWeather(city: cityName)
    }
    
    
    var body: some View {
        
        NavigationView{
            
            ZStack(alignment: .center){
                GeometryReader{ geometry in
                    Image("background")
                        .resizable()
                        .aspectRatio(geometry.size,contentMode: .fill)
                        .ignoresSafeArea()
                    ScrollView(.vertical,showsIndicators: false){
                        
                        VStack{
                            
                            ForEach(weatherForecastVM.forecastWeather.sorted(by: {$0.key < $1.key}), id: \.key) { key, value in
                                ZStack{
                                    Image("background")
                                        .resizable()
                                        .opacity(0.3)
                                        .frame(width: UIScreen.main.bounds.width * 0.95,height: UIScreen.main.bounds.height*0.27)
                                        .cornerRadius(30)
                                    VStack{
                                        HStack{
                                            Text("\(key.formatted(.dateTime.day().month().year()))")
                                                .padding(EdgeInsets(top: 5, leading: 25, bottom: 0, trailing: 0))
                                                .font(.custom("Arial", size: 28))
                                                .foregroundColor(.white)
                                                .bold()
                                            Spacer()
                                        }
                                        
                                        ScrollView(.horizontal,showsIndicators: false){
                                            HStack{
                                                ForEach(value,id: \.id){item in
                                                    VStack{
                                                        Text(dateFormatter.string(from: item.dt!))
                                                            .font(.custom("Arial", size: 18))
                                                            .foregroundColor(.white)
                                                            .bold()
                                                        URLImage(URL(string: "https://openweathermap.org/img/wn/\(item.icon!)@2x.png")!) { image, info in
                                                            image.resizable()
                                                                .frame(width: 100,height: 100)
                                                                .shadow(radius: 10,x: 15,y: 15)
                                                        }
                                                        Text(String(format: "%.0f°C", item.temp!))
                                                            .font(.custom("Arial", size: 18))
                                                            .foregroundColor(.white)
                                                            .bold()
                                                        Spacer()
                                                    }
                                                    
                                                }
                                                
                                            }
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                        
                        
                        
                        
                    }
                }
            }
            
            .navigationBarItems(leading:
                                    Button(action: {
                dismiss()
                
            }, label: {
                HStack {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .bold()
                    Text("Back")
                        .foregroundColor(.white)
                        .bold()
                    
                }
            })
            )}
    }
    
    struct WeatherForecastView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherForecastView(cityName: "Bangkok")
        }
    }
}
