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
    var errorMessage: String?

    func fetchWeather(for area: String) {
        do {
            let condition = try YumemiWeather.fetchWeatherCondition(at: area)
            weather = Weather(rawValue: condition) ?? .unknown
            errorMessage = nil
        } catch let error as YumemiWeatherError {
            weather = .unknown
            switch error {
            case .invalidParameterError:
                errorMessage = "不正な地域名が指定されました。"
            case .unknownError:
                errorMessage = "不明なエラーが発生しました。"
            }
        } catch {
            weather = .unknown
            errorMessage = "予期せぬエラーが発生しました。"
        }
    }
}
