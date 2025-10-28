//
//  WeatherState.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/20.
//

enum WeatherState {
    case idle
    case loading
    case success(WeatherInfo)
    case failure(WeatherError)
}

struct WeatherInfo {
    let condition: Weather?
    let minTemp: Int
    let maxTemp: Int
}
