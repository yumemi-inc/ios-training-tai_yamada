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
        case .invalidParameter:
            return "地域情報を再選択して、もう一度お試しください。"
        case .unknown:
            return "通信状況をご確認のうえ、もう一度お試しください。"
        case .unexpected:
            return "アプリを再起動しても解決しない場合は、サポートにお問い合わせください。"
        }
    }
}
