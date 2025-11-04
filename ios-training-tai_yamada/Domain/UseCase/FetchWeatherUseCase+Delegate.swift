//
//  FetchWeatherUseCase+Delegate.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/11/04.
//

import Foundation

protocol FetchWeatherUseCaseDelegate: AnyObject {
    func fetchWeatherDidSucceed(info: WeatherInfo)
    func fetchWeatherDidFail(error: Error)
}

protocol FetchWeatherUseCaseDelegateDriven {
    var delegate: FetchWeatherUseCaseDelegate? { get set }
    func execute(area: String, date: Date)
}


final class DefaultFetchWeatherUseCaseDelegateDriven: FetchWeatherUseCaseDelegateDriven {
    weak var delegate: FetchWeatherUseCaseDelegate?

    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    func execute(area: String, date: Date) {
        Task.detached(priority: .userInitiated) { [weak self] in
            guard let self else { return }
            do {
                let info = try self.repository.fetch(area: area, date: date)
                await MainActor.run { [weak self] in
                    self?.delegate?.fetchWeatherDidSucceed(info: info)
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.delegate?.fetchWeatherDidFail(error: error)
                }
            }
        }
    }
}

