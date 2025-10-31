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
    
    func testFetchWeather_setsFailureState_whenUseCaseThrowsWeatherError() {
        
        struct FailingUseCase: FetchWeatherUseCase {
            func execute(area: String, date: Date) throws -> WeatherInfo {
                throw WeatherError(kind: .unexpected)
            }
        }
        let vm = WeatherViewModel(useCase: FailingUseCase())

        vm.fetchWeather(for: "tokyo")

        if case .failure(let error as WeatherError) = vm.state {
            XCTAssertEqual(error.kind, .unexpected, "Expected WeatherError.kind = .unexpected")
        } else {
            XCTFail("Expected failure state with WeatherError(.unexpected)")
        }
    }
}

