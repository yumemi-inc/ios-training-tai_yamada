//
//  WeatherViewModel.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class WeatherViewModel {
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository = DefaultWeatherRepository()) {
        self.repository = repository
    }
    var state: WeatherState = .idle
    var error: WeatherError? {
        if case .failure(let error) = state {
            return error
        }
        return nil
    }

    func fetchWeather(for area: String) {
        state = .loading
        do {
            let info = try repository.fetch(area: area, date: .now)
            state = .success(info)
        } catch let weatherError as WeatherError {
            state = .failure(weatherError)
        } catch {
            state = .failure(WeatherError(kind: .unexpected, underlyingError: error))
        }
    }
    
    func dismissError() {
        state = .idle
    }
}
