//
//  WeatherError.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/20.
//

import Foundation

struct WeatherError: Error, Identifiable {
    let id = UUID()
    let kind: Kind
    let underlyingError: Error?

    enum Kind {
        case invalidParameter
        case unknown
        case unexpected
    }

    init(kind: Kind, underlyingError: Error? = nil) {
        self.kind = kind
        self.underlyingError = underlyingError
    }
}

extension WeatherError: LocalizedError {
    var errorDescription: String? {
        switch kind {
        case .invalidParameter: return "不正な地域名が指定されました。"
        case .unknown:          return "不明なエラーが発生しました。"
        case .unexpected:       return "予期せぬエラーが発生しました。"
        }
    }
}
