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
    @Published var errorMessage: String? = nil

    func fetchWeather(for area: String) {
        do {
            let result = try YumemiWeather.fetchWeatherCondition(at: area)
            weather = result
            errorMessage = nil
        } catch let error as YumemiWeatherError {
            switch error {
            case .invalidParameterError:
                errorMessage = "不正な地域名が指定されました。"
            case .unknownError:
                errorMessage = "不明なエラーが発生しました。"
            }
        } catch {
            errorMessage = "予期せぬエラーが発生しました。"
        }
    }
}
