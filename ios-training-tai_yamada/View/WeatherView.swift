//
//  WeatherView.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import SwiftUI

struct WeatherView: View {
    @State private var viewModel = WeatherViewModel()
    @State private var selectedArea = "tokyo"
    
    var body: some View {
        VStack(spacing: 0) {
            if let weather = viewModel.weather {
                weather.image
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal, count: 2, spacing: 0)
                    .foregroundStyle(imageColor(for: weather))
            }
            
            HStack(spacing: 0) {
                Text("ー ー")
                    .foregroundColor(.blue)
                    .containerRelativeFrame(.horizontal, count: 4, spacing: 0)
                Text("ー ー")
                    .foregroundColor(.red)
                    .containerRelativeFrame(.horizontal, count: 4, spacing: 0)
            }
            
            HStack(spacing: 0) {
                // TODO: Closeボタンの機能は今後のタスクで実装する
                Button("Close") {}
                    .foregroundColor(.blue)
                    .containerRelativeFrame(.horizontal, count: 4, spacing: 0)
                
                Button("Reload") {
                    viewModel.fetchWeather(for: selectedArea)
                }
                .foregroundColor(.blue)
                .containerRelativeFrame(.horizontal, count: 4, spacing: 0)
            }
            .padding(.top, 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .onAppear {
            viewModel.fetchWeather(for: selectedArea)
        }
        .alert("エラー", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
    
    private func imageColor(for weather: Weather) -> Color {
        switch weather {
        case .sunny: return .red
        case .cloudy: return .gray
        case .rainy: return .blue
        case .unknown: return .black
        }
    }
}

#Preview {
    WeatherView()
}
