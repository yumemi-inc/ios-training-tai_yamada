//
//  WeatherViewModel+Delegate.swift
//  ios-training-tai_yamada
//
//  Created by 山田大陽 on 2025/11/04.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class WeatherViewModelDelegateDriven: FetchWeatherUseCaseDelegate {
    private var delegateUseCase: FetchWeatherUseCaseDelegateDriven

    init(delegateUseCase: FetchWeatherUseCaseDelegateDriven) {
        self.delegateUseCase = delegateUseCase
        self.delegateUseCase.delegate = self
    }

    var state: WeatherState = .idle
    var error: Error? {
        if case .failure(let err) = state { return err }
        return nil
    }

    func fetchWeather(for area: String) {
        state = .loading
        delegateUseCase.execute(area: area, date: .now)
    }

    func dismissError() { state = .idle }

    func fetchWeatherDidSucceed(info: WeatherInfo) { state = .success(info) }
    func fetchWeatherDidFail(error: Error) { state = .failure(error) }
}
