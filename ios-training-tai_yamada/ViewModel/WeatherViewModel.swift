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
    var state: WeatherState = .idle

    func fetchWeather(for area: String) {
        state = .loading
        do {
            let condition = try YumemiWeather.fetchWeatherCondition(at: area)
            let weather = Weather(rawValue: condition) ?? .unknown
            state = .success(weather)
        } catch let error as YumemiWeatherError {
            switch error {
            case .invalidParameterError:
                state = .failure("不正な地域名が指定されました。")
            case .unknownError:
                state = .failure("不明なエラーが発生しました。")
            }
        } catch {
            state = .failure("予期せぬエラーが発生しました。")
        }
    }
}
