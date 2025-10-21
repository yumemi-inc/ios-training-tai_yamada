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
    var error: WeatherError? {
        if case .failure(let error) = state {
            return error
        }
        return nil
    }

    func fetchWeather(for area: String) {
        state = .loading
        do {
            let condition = try YumemiWeather.fetchWeatherCondition(at: area)
            let weather = Weather(rawValue: condition) ?? .unknown
            state = .success(weather)
        } catch {
            state = .failure(makeWeatherError(from: error))
        }
    }
    
    func dismissError() {
        state = .idle
    }

    private func makeWeatherError(from error: Error) -> WeatherError {
        if let yumemiError = error as? YumemiWeatherError {
            switch yumemiError {
            case .invalidParameterError:
                return WeatherError(kind: .invalidParameter, underlyingError: error)
            case .unknownError:
                return WeatherError(kind: .unknown, underlyingError: error)
            }
        } else {
            return WeatherError(kind: .unexpected, underlyingError: error)
        }
    }
}
