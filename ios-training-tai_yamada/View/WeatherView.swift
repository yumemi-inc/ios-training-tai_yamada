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
                Image(viewModel.weather)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.5) // 幅は画面の半分
                    .frame(height: geometry.size.width * 0.5) // 高さは幅と同じ
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(imageColor)

                HStack(spacing: 0) {
                    Text("ー ー")
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width * 0.25) // 画像の半分
                    Text("ー ー")
                        .foregroundColor(.red)
                        .frame(width: geometry.size.width * 0.25)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                HStack(spacing: 0) {
                    Text("Close")
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width * 0.25)
                    
                    Button("Reload") {
                        viewModel.fetchWeather(for: "tokyo")
                    }
                    .foregroundColor(.blue)
                    .frame(width: geometry.size.width * 0.25)
                    
                }
                .padding(.top, 80) // Labelとの隙間は80pt
                
            }
            .frame(maxHeight: .infinity, alignment: .center) // VStack全体を中央に
        }
        .onAppear {
            viewModel.fetchWeather(for: "tokyo")
        }
        // エラーハンドリング
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
        switch viewModel.weather {
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
