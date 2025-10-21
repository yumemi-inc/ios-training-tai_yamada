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
        } catch let error as YumemiWeatherError {
            let weatherError = makeWeatherError(from: error)
            state = .failure(weatherError)
        } catch {
            let weatherError = WeatherError(kind: .unexpected, underlyingError: error)
            state = .failure(WeatherError(kind: .unexpected, underlyingError: error))
        }
    }
    
    func dismissError() {
        state = .idle
    }

    private func makeWeatherError(from error: YumemiWeatherError) -> WeatherError {
        switch error {
        case .invalidParameterError:
            return WeatherError(kind: .invalidParameter, underlyingError: error)
        case .unknownError:
            return WeatherError(kind: .unknown, underlyingError: error)
        }
    }
}
