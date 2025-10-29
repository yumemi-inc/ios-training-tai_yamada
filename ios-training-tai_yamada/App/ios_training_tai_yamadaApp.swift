//
//  ios_training_tai_yamadaApp.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import SwiftUI
import Resolver

@main
struct ios_training_tai_yamadaApp: App {
    init() {
        // Ensure registrations happen at app/bootstrap time
        Resolver.registerAllServices()
    }
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
