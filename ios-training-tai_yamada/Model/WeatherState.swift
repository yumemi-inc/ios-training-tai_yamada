//
//  WeatherState.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/20.
//

import Foundation

enum WeatherState {
    case idle
    case loading
    case success(Weather)
    case failure(String)
}
