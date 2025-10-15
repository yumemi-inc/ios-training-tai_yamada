//
//  WeatherViewModel.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import Foundation
import Combine
import YumemiWeather

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var errorMessage: String?
    
    private let isoFormatter = ISO8601DateFormatter()

    func fetchWeather(for area: String) {
        do {
            let request: [String: Any] = [
                "area": area,
                "date": isoFormatter.string(from: .now)
            ]
            let jsonData = try JSONSerialization.data(withJSONObject: request)
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                errorMessage = "JSON変換に失敗しました。"
                return
            }

            let responseString = try YumemiWeather.fetchWeather(jsonString)
            let responseData = Data(responseString.utf8)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(WeatherResponse.self, from: responseData)
            
            weather = decoded
            errorMessage = nil

        } catch let error as YumemiWeatherError {
            switch error {
            case .invalidParameterError:
                errorMessage = "不正なリクエストです。"
            case .unknownError:
                errorMessage = "天気情報の取得に失敗しました。"
            }
            weather = nil

        } catch {
            errorMessage = "予期せぬエラー: \(error.localizedDescription)"
            weather = nil
        }
    }
}
