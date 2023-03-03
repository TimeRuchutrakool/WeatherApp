//
//  ContentView.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/2/23.
//

import SwiftUI

struct ContentView: View {
    
    private var weatherCurrentVM = WeatherForecastViewModel()
    
    
    var body: some View {
        VStack {
            Button("Fetch") {
                weatherCurrentVM.fetchForcastWeather(city: "bangkok")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
