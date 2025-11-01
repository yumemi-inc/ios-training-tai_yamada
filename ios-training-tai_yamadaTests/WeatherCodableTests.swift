//
//  WeatherCodableTests.swift
//  ios-training-tai_yamadaTests
//
//  Created by 山田 大陽 on 2025/10/29.
//

import XCTest
@testable import ios_training_tai_yamada

final class WeatherCodableTests: XCTestCase {
    func testWeatherRequestEncoding_usesISO8601AndSnakeCase() throws {
        let date = ISO8601DateFormatter().date(from: "2025-10-29T10:00:00Z")!
        let request = WeatherRequest(area: "tokyo", date: date)

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(request)

        let obj = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        XCTAssertEqual(obj["area"] as? String, "tokyo")
        XCTAssertEqual(obj["date"] as? String, "2025-10-29T10:00:00Z")
    }

    func testWeatherResponseDecoding_fromSnakeCaseJSON() throws {
        let json = """
        {"max_temperature": 25, "min_temperature": 13, "date": "2025-10-29T10:00:00Z", "weather_condition": "sunny"}
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let response = try decoder.decode(WeatherResponse.self, from: json)
        XCTAssertEqual(response.maxTemperature, 25)
        XCTAssertEqual(response.minTemperature, 13)
        XCTAssertEqual(response.date, "2025-10-29T10:00:00Z")
        XCTAssertEqual(response.weatherCondition, "sunny")
    }
}

