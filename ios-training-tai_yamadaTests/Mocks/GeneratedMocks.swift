//
//  ios_training_tai_yamadaTests.swift
//  ios-training-tai_yamadaTests
//
//  Created by 山田 大陽 on 2025/11/04.
//


import Foundation
@testable import ios_training_tai_yamada

final class FetchWeatherUseCaseMock: FetchWeatherUseCase {
    var executeHandler: ((_ area: String, _ date: Date) throws -> WeatherInfo)?

    func execute(area: String, date: Date) throws -> WeatherInfo {
        if let handler = executeHandler {
            return try handler(area, date)
        }
        fatalError("executeHandler not set")
    }
}

