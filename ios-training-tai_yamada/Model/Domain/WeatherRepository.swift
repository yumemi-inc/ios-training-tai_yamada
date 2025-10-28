//
//  WeatherRepository.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/28.
//

import Foundation

protocol WeatherRepository {
    func fetch(area: String, date: Date) throws -> WeatherInfo
}

