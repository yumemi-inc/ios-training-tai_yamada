//
//  WeatherViewModelTests.swift
//  ios-training-tai_yamadaTests
//
//  Created by 山田 大陽 on 2025/10/29.
//

import XCTest
@testable import ios_training_tai_yamada

@MainActor
final class WeatherViewModelTests: XCTestCase {
    func testFetchWeather_setsSuccessState() {
        let vm = WeatherViewModel(useCase: StubFetchWeatherUseCase(condition: .cloudy, min: 5, max: 15))
                
        if case .idle = vm.state {
            // idle状態のテストOK
        } else {
            XCTFail("Expected idle state")
        }

        vm.fetchWeather(for: "tokyo")
        
        if case .success(let info) = vm.state {
            XCTAssertEqual(info.condition, .cloudy)
            XCTAssertEqual(info.minTemp, 5)
            XCTAssertEqual(info.maxTemp, 15)
        } else {
            XCTFail("Expected success state")
        }
    }
}

