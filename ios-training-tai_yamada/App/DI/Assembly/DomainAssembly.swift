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
        // MARK: - 同期版 UseCase（Mockolo / テスト用）
        Resolver.register { DefaultFetchWeatherUseCase(repository: Resolver.resolve()) as FetchWeatherUseCase }
        
        // MARK: - Delegate 駆動版 UseCase（課題対応）
        Resolver.register { DefaultFetchWeatherUseCaseDelegateDriven(repository: Resolver.resolve()) as FetchWeatherUseCaseDelegateDriven }
    }
}

