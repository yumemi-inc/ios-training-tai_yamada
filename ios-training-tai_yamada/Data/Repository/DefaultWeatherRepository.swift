//
//  DefaultWeatherRepository.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/28.
//

import Foundation

struct DefaultWeatherRepository: WeatherRepository {
    private let service: WeatherService


    func fetch(area: String, date: Date) throws -> WeatherInfo {
        let response = try service.fetch(area: area, date: date)
        guard let condition = Weather(rawValue: response.weatherCondition) else {
            throw WeatherError(kind: .unexpected, underlyingError: nil)
        }
        return WeatherInfo(
            condition: condition,
            minTemp: response.minTemperature,
            maxTemp: response.maxTemperature
        )
    }
}
