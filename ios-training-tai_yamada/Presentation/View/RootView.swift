//
//  RootView.swift
//  ios-training-tai_yamada
//
//  Created by 山田大陽 on 2025/10/28.
//

import SwiftUI

struct RootView: View {
    @State private var showWeather = false

    var body: some View {
        Color.black
            .ignoresSafeArea()
            .onAppear {
                showWeather = true
            }
            .fullScreenCover(isPresented: $showWeather, onDismiss: {
                Task { @MainActor in
                    try? await Task.sleep(for: .seconds(0.5))
                    showWeather = true
                }
            }) {
                WeatherView()
            }
    }
}
