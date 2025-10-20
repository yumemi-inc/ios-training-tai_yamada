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
            let weatherError: WeatherError
            switch error {
            case .invalidParameterError:
                weatherError = WeatherError(kind: .invalidParameter, underlyingError: error)
            case .unknownError:
                weatherError = WeatherError(kind: .unknown, underlyingError: error)
            }
            state = .failure(weatherError)
        } catch {
            state = .failure(WeatherError(kind: .unexpected, underlyingError: error))
        }
    }
}
