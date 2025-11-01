//
//  WeatherResponse.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/15.
//


import Foundation

struct WeatherResponse: Decodable {
    let maxTemperature: Int
    let minTemperature: Int
    let date: String
    let weatherCondition: String
}

