//
//  DomainAssembly.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/29.
//

import Foundation
import Resolver

enum DomainAssembly {
    static func register() {
        Resolver.register { DefaultFetchWeatherUseCase(repository: Resolver.resolve()) as FetchWeatherUseCase }
        Resolver.register { DefaultFetchWeatherUseCaseDelegateDriven(repository: Resolver.resolve()) as FetchWeatherUseCaseDelegateDriven }
    }
}

