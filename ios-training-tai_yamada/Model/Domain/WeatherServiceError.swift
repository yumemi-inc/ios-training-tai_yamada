//
//  WeatherServiceError.swift
//  ios-training-tai_yamada
//
//  Created by 山田大陽 on 2025/10/28.
//

enum WeatherServiceError: Error {
    case invalidParameter
    case unknown
    case unexpected(Error)
}
