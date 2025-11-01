//
//  StubWeatherRepository.swift
//  ios-training-tai_yamadaTests
//
//  Created by 山田 大陽 on 2025/10/29.
//

import Foundation
@testable import ios_training_tai_yamada

struct StubWeatherRepository: WeatherRepository {
    let info: WeatherInfo

    init(condition: Weather, min: Int, max: Int) {
        self.info = WeatherInfo(condition: condition, minTemp: min, maxTemp: max)
    }

    init(info: WeatherInfo) {
        self.info = info
    }

    func fetch(area: String, date: Date) throws -> WeatherInfo {
        info
    }
}

