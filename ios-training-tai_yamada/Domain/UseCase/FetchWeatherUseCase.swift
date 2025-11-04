//
//  FetchWeatherUseCase.swift
//  ios-training-tai_yamada
//
//  Created by 山田大陽 on 2025/10/29.
//
// Delegate 駆動版 (`FetchWeatherUseCaseDelegateDriven`) と併存しています。
// 今後のタスク再利用予定

import Foundation

/// @mockable
protocol FetchWeatherUseCase {
    func execute(area: String, date: Date) throws -> WeatherInfo
}

struct DefaultFetchWeatherUseCase: FetchWeatherUseCase {
    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    func execute(area: String, date: Date) throws -> WeatherInfo {
        try repository.fetch(area: area, date: date)
    }
}

