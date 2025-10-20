//
//  WeatherViewModel.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import SwiftUI
import Combine
import YumemiWeather

@MainActor
@Observable
final class WeatherViewModel {
    var weather: Weather?
    
    func fetchWeather() {
        let condition = YumemiWeather.fetchWeatherCondition()
        weather = Weather(rawValue: condition) ?? .unknown
    }
}
