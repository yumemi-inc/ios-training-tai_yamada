//
//  PresentationAssembly.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/29.
//

import Foundation
import Resolver

enum PresentationAssembly {
    static func register() {
        Resolver.register {
            MainActor.assumeIsolated {
                // NOTE: Delegateパターン学習用の構成。
                //       同期版(useCase:)も残してあり、用途に応じて切り替え可能。
//                WeatherViewModel(useCase: Resolver.resolve())
                WeatherViewModel(delegateUseCase: Resolver.resolve())
            }
        }
    }
}

