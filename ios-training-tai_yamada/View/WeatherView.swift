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
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                    .foregroundStyle(imageColor)

                HStack(spacing: 0) {
                    Text("ー ー")
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width * 0.25) // 画像の半分
                    Text("ー ー")
                        .foregroundColor(.red)
                        .frame(width: geometry.size.width * 0.25)
                }
                
                HStack(spacing: 0) {
                    // Closeボタンの機能は今後のタスクで実装する
                    Button(action: {}) {
                        Text("Close")
                            .foregroundColor(.blue)
                            .frame(width: geometry.size.width * 0.25)
                    }
                    
                    Button("Reload") {
                        viewModel.fetchWeather()
                    }
                    .foregroundColor(.blue)
                    .frame(width: geometry.size.width * 0.25)
                    
                }
                .padding(.top, 80)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .onAppear {
            viewModel.fetchWeather()
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

