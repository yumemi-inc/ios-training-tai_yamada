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
        let exp = expectation(description: "UseCase execute called")

        let mock = FetchWeatherUseCaseMock { area, date in
            XCTAssertEqual(area, "tokyo")
            exp.fulfill()
            return WeatherInfo(condition: .cloudy, minTemp: 5, maxTemp: 15)
        }

        let vm = WeatherViewModel(useCase: mock)

        if case .idle = vm.state {
            // idle状態のテストOK
        } else {
            XCTFail("Expected idle state")
        }

        vm.fetchWeather(for: "tokyo")
        await fulfillment(of: [exp], timeout: 1.0)

        if case .success(let info) = vm.state {
            XCTAssertEqual(info.condition, .cloudy)
            XCTAssertEqual(info.minTemp, 5)
            XCTAssertEqual(info.maxTemp, 15)
        } else {
            XCTFail("Expected success state")
        }
    }

    func testFetchWeather_setsFailureState_whenUseCaseThrowsWeatherError() async throws {
        let exp = expectation(description: "UseCase execute called")

        let mock = FetchWeatherUseCaseMock { _, _ in
            exp.fulfill()
            throw WeatherError(kind: .unexpected)
        }

        let vm = WeatherViewModel(useCase: mock)
        vm.fetchWeather(for: "tokyo")
        await fulfillment(of: [exp], timeout: 1.0)

        if case .failure(let error as WeatherError) = vm.state {
            XCTAssertEqual(error.kind, .unexpected, "Expected WeatherError.kind = .unexpected")
        } else {
            XCTFail("Expected failure state with WeatherError(.unexpected)")
        }
    }
}
