//
//  DefaultWeatherRepository.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/28.
//

import Foundation
import YumemiWeather

struct DefaultWeatherRepository: WeatherRepository {
    private let service: WeatherService

    init(service: WeatherService) {
        self.service = service
    }

    func fetch(area: String, date: Date) throws -> WeatherInfo {
        do {
            let response = try service.fetch(area: area, date: date)
            return WeatherInfo(
                condition: Weather(rawValue: response.weatherCondition),
                minTemp: response.minTemperature,
                maxTemp: response.maxTemperature
            )
        } catch {
            throw mapError(error)
        }
    }

    private func mapError(_ error: Error) -> WeatherError {
        if let yumemiError = error as? YumemiWeatherError {
            switch yumemiError {
            case .invalidParameterError:
                return WeatherError(kind: .invalidParameter, underlyingError: error)
            case .unknownError:
                return WeatherError(kind: .unknown, underlyingError: error)
            }
        }
        return WeatherError(kind: .unexpected, underlyingError: error)
    }
}

