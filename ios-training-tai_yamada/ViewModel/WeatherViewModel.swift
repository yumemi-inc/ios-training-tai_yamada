//
//  WeatherViewModel.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import Observation
import YumemiWeather

@MainActor
@Observable
final class WeatherViewModel {
    var weather: Weather?
    var errorMessage: String?

    func fetchWeather(for area: String) {
        do {
            let condition = try YumemiWeather.fetchWeatherCondition(at: area)
            
            if let w = Weather(rawValue: condition) {
                weather = w
                errorMessage = nil
            } else {
                weather = nil
                errorMessage = "未知の天気: \(condition)"
            }
        } catch let error as YumemiWeatherError {
            weather = nil
            switch error {
            case .invalidParameterError:
                errorMessage = "不正な地域名が指定されました。"
            case .unknownError:
                errorMessage = "不明なエラーが発生しました。"
            }
        } catch {
            weather = nil
            errorMessage = "予期せぬエラーが発生しました。"
        }
    }
}
