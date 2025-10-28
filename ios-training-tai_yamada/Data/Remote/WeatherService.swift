//
//  WeatherService.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/28.
//

import Foundation
import YumemiWeather

protocol WeatherService {
    func fetch(area: String, date: Date) throws -> WeatherResponse
}

struct YumemiWeatherService: WeatherService {
    func fetch(area: String, date: Date) throws -> WeatherResponse {
        do {
            let request = WeatherRequest(area: area, date: date)

            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.dateEncodingStrategy = .iso8601
            let requestData = try encoder.encode(request)
            let requestString = String(decoding: requestData, as: UTF8.self)

            let responseString = try YumemiWeather.fetchWeather(requestString)

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(WeatherResponse.self, from: Data(responseString.utf8))
            return response
        } catch {
            if let yumemiError = error as? YumemiWeatherError {
                switch yumemiError {
                case .invalidParameterError:
                    throw WeatherError(kind: .invalidParameter, underlyingError: yumemiError)
                case .unknownError:
                    throw WeatherError(kind: .unknown, underlyingError: yumemiError)
                }
            }
            throw WeatherError(kind: .unexpected, underlyingError: error)
        }
    }
}
