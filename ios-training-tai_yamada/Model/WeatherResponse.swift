//
//  WeatherResponse.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/15.
//


import Foundation

struct WeatherResponse: Codable {
    let maxTemperature: Int
    let minTemperature: Int
    let weatherCondition: String
    let date: Date
}
