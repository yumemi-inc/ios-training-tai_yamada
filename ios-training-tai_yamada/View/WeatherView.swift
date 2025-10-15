//
//  ContentView.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Image(viewModel.weather?.weatherCondition ?? "sunny")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                    .foregroundStyle(imageColor)

                HStack(spacing: 0) {
                    Text("\(viewModel.weather?.minTemperature ?? 0)")
                        .foregroundColor(.blue)
                        .font(.system(size: 35, weight: .light))
                        .frame(width: geometry.size.width * 0.25)

                    Text("\(viewModel.weather?.maxTemperature ?? 0)")
                        .foregroundColor(.red)
                        .font(.system(size: 35, weight: .light))
                        .frame(width: geometry.size.width * 0.25)
                }

                HStack(spacing: 0) {
                    // TODO: Closeボタンの機能は今後のタスクで実装する
                    Button(action: {}) {
                        Text("Close")
                            .foregroundColor(.blue)
                            .frame(width: geometry.size.width * 0.25)
                    }
                    
                    Button("Reload") {
                        // 今回のタスクではパラメータを tokyo で固定にしています。
                        viewModel.fetchWeather(for: "tokyo")
                    }
                    .foregroundColor(.blue)
                    .frame(width: geometry.size.width * 0.25)
                    
                }
                .padding(.top, 80)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .onAppear {
            // 今回のタスクではパラメータを tokyo で固定にしています。
            viewModel.fetchWeather(for: "tokyo")
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
    
    private var imageColor: Color {
        switch viewModel.weather?.weatherCondition {
        case "sunny": return .red
        case "cloudy": return .gray
        case "rainy": return .blue
        default: return .black
        }
    }
}

#Preview {
    WeatherView()
}
