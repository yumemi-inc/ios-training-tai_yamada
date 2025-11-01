//
//  Resolver+Registration.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/29.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        DataAssembly.register()
        DomainAssembly.register()
        PresentationAssembly.register()
    }
}
