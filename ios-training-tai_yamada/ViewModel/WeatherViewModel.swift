//
//  WeatherViewModel.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import SwiftUI
import Combine
import YumemiWeather

@Observable
final class WeatherViewModel {
    var weather: String = "sunny"
    
    func fetchWeather() {
        weather = YumemiWeather.fetchWeatherCondition()
        print("取得した天気: \(weather)")
    }
}
