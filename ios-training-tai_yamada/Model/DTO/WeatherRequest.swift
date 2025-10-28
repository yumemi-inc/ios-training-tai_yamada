//
//  WeatherRequest.swift
//  ios-training-tai_yamada
//
//  Created by 山田大陽 on 2025/10/28.
//

import Foundation

struct WeatherRequest: Encodable {
    let area: String
    let date: Date
}

