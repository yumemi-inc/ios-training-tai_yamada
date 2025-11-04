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
    private let fetchWeather: FetchWeatherUseCase

    init(useCase: FetchWeatherUseCase) {
        self.fetchWeather = useCase
    }
    var state: WeatherState = .idle
    var error: Error? {
        if case .failure(let err) = state { return err }
        return nil
    }

    func fetchWeather(for area: String) {
        state = .loading
        Task(priority: .userInitiated) { [weak self] in
            guard let self else { return }
            do {
                let info = try self.fetchWeather.execute(area: area, date: .now)
                await MainActor.run { self.state = .success(info) }
            } catch {
                await MainActor.run { self.state = .failure(error) }
            }
        }
    }

    
    func dismissError() {
        state = .idle
    }
}
