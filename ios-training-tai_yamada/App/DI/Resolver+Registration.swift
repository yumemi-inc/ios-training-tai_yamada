//
//  Resolver+Registration.swift
//  ios-training-tai_yamada
//
//  Created by 山田大陽 on 2025/10/29.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        // UI test stub switching via environment
        let env = ProcessInfo.processInfo.environment
        if env["UITEST_STUB"] == "1" {
            struct StubService: WeatherService {
                let condition: Weather
                let min: Int
                let max: Int
                func fetch(area: String, date: Date) throws -> WeatherResponse {
                    WeatherResponse(maxTemperature: max, minTemperature: min, date: ISO8601DateFormatter().string(from: date), weatherCondition: condition.rawValue)
                }
            }
            let cond = Weather(rawValue: env["STUB_CONDITION"] ?? "sunny") ?? .sunny
            let min = Int(env["STUB_MIN"] ?? "10") ?? 10
            let max = Int(env["STUB_MAX"] ?? "20") ?? 20

            register { StubService(condition: cond, min: min, max: max) as WeatherService }
        } else {
            register { YumemiWeatherService() as WeatherService }
        }

        register { DefaultWeatherRepository(service: resolve()) as WeatherRepository }
        register { DefaultFetchWeatherUseCase(repository: resolve()) as FetchWeatherUseCase }
        register {
            MainActor.assumeIsolated {
                WeatherViewModel(useCase: resolve())
            }
        }
    }
}
