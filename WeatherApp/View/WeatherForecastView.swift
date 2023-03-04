//
//  WeatherForecastView.swift
//  WeatherApp
//
//  Created by Time Ruchutrakool on 3/4/23.
//

import SwiftUI

struct WeatherForecastView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
    }
}

struct WeatherForecastView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherForecastView(cityName: "")
    }
}
