//
//  WeatherViewModel.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import Combine
import YumemiWeather

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var weather: String = "sunny"
    
    func fetchWeather() {
        weather = YumemiWeather.fetchWeatherCondition()
        print("取得した天気: \(weather)")
    }
}
