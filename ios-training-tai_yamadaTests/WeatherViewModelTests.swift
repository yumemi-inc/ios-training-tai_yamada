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
    func testFetchWeather_setsSuccessState() async throws {
        let mock = FetchWeatherUseCaseMock()
        let vm = WeatherViewModel(useCase: mock)
        let exp = expectation(description: "UseCase execute called")

        if case .idle = vm.state {
            // idle状態のテストOK
        } else {
            XCTFail("Expected idle state")
        }

        mock.executeHandler = { area, date in
            XCTAssertEqual(area, "tokyo")
            exp.fulfill()
            return WeatherInfo(condition: .cloudy, minTemp: 5, maxTemp: 15)
        }

        vm.fetchWeather(for: "tokyo")
        await fulfillment(of: [exp], timeout: 1.0)
        
        await Task.yield(); await Task.yield()

        if case .success(let info) = vm.state {
            XCTAssertEqual(info.condition, .cloudy)
            XCTAssertEqual(info.minTemp, 5)
            XCTAssertEqual(info.maxTemp, 15)
        } else {
            XCTFail("Expected success state")
        }
    }
    
    func testFetchWeather_setsFailureState_whenUseCaseThrowsWeatherError() async throws {
        let mock = FetchWeatherUseCaseMock()
        let vm = WeatherViewModel(useCase: mock)
        let exp = expectation(description: "UseCase execute called")

        mock.executeHandler = { _, _ in
            exp.fulfill()
            throw WeatherError(kind: .unexpected)
        }

        vm.fetchWeather(for: "tokyo")
        await fulfillment(of: [exp], timeout: 1.0)
        
        await Task.yield(); await Task.yield()

        if case .failure(let error as WeatherError) = vm.state {
            XCTAssertEqual(error.kind, .unexpected, "Expected WeatherError.kind = .unexpected")
        } else {
            XCTFail("Expected failure state with WeatherError(.unexpected)")
        }
    }
}
