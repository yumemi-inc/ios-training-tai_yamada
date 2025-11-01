//
//  WeatherUITests.swift
//  ios-training-tai_yamadaUITests
//
//  Created by 山田 大陽 on 2025/10/29.
//

import XCTest

final class WeatherUITests: XCTestCase {
    func testSunnyIconAndTemperatures() {
        let app = XCUIApplication()
        app.launchEnvironment["UITEST_STUB"] = "1"
        app.launchEnvironment["STUB_CONDITION"] = "sunny"
        app.launchEnvironment["STUB_MIN"] = "10"
        app.launchEnvironment["STUB_MAX"] = "20"
        app.launch()

        XCTAssertTrue(app.images["weatherIcon_sunny"].waitForExistence(timeout: 3))
        XCTAssertEqual(app.staticTexts["minTempLabel"].label, "10")
        XCTAssertEqual(app.staticTexts["maxTempLabel"].label, "20")
    }

    func testCloudyIconDisplayed() {
        let app = XCUIApplication()
        app.launchEnvironment["UITEST_STUB"] = "1"
        app.launchEnvironment["STUB_CONDITION"] = "cloudy"
        app.launch()

        XCTAssertTrue(app.images["weatherIcon_cloudy"].waitForExistence(timeout: 3))
    }

    func testRainyIconDisplayed() {
        let app = XCUIApplication()
        app.launchEnvironment["UITEST_STUB"] = "1"
        app.launchEnvironment["STUB_CONDITION"] = "rainy"
        app.launch()

        XCTAssertTrue(app.images["weatherIcon_rainy"].waitForExistence(timeout: 3))
    }
}

