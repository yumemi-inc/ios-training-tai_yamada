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
                WeatherViewModel(useCase: Resolver.resolve())
            }
        }
    }
}

