//
//  ios_training_tai_yamadaTests.swift
//  ios-training-tai_yamadaTests
//
//  Created by 山田 大陽 on 2025/11/04.
//


import Foundation
@testable import ios_training_tai_yamada

final class FetchWeatherUseCaseMock: FetchWeatherUseCase {
    private let executeHandler: (_ area: String, _ date: Date) throws -> WeatherInfo

    init(executeHandler: @escaping (_ area: String, _ date: Date) throws -> WeatherInfo) {
        self.executeHandler = executeHandler
    }

    func execute(area: String, date: Date) throws -> WeatherInfo {
        try executeHandler(area, date)
    }
}

