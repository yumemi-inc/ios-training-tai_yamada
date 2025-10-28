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
    var error: Error? {
        if case .failure(let err) = state { return err }
        return nil
    }

    func fetchWeather(for area: String) {
        state = .loading
        do {
            let info = try repository.fetch(area: area, date: .now)
            state = .success(info)
        } catch {
            state = .failure(error)
        }
    }
    
    func dismissError() {
        state = .idle
    }
}
