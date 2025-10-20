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
            ZStack {
                Color.clear
                    .aspectRatio(1, contentMode: .fit)
                
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView()
                        .tint(.gray)
                        .aspectRatio(1, contentMode: .fit)

                case .success(let weather):
                    weather.image
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(imageColor(for: weather))

                case .failure:
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                }
            }
            .containerRelativeFrame(.horizontal, count: 2, spacing: 0)
            
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
        .alert("エラー", isPresented: $viewModel.showErrorAlert) {
            Button("OK", role: .cancel) {
                viewModel.clearError()
            }
        } message: {
            if case .failure(let error) = viewModel.state {
                Text(localizedErrorMessage(for: error))
            }
        }

    }
    
    private func localizedErrorMessage(for error: WeatherError) -> String {
        switch error {
        case .invalidParameter: return "不正な地域名が指定されました。"
        case .unknown: return "不明なエラーが発生しました。"
        case .unexpected: return "予期せぬエラーが発生しました。"
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
