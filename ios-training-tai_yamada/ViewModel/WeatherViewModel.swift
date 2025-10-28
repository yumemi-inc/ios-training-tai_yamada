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
            let request = WeatherRequest(area: area)

            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let requestString = try String(data: encoder.encode(request), encoding: .utf8)!
            
            let responseString = try YumemiWeather.fetchWeather(requestString)

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(WeatherResponse.self, from: Data(responseString.utf8))

            let info = WeatherInfo(
                condition: Weather(rawValue: response.weatherCondition),
                minTemp: response.minTemperature,
                maxTemp: response.maxTemperature
            )
            
            state = .success(info)
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
