//
//  WeatherView.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import SwiftUI

struct WeatherView: View {
    @State private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            
            Image(viewModel.weather)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal, count: 2, spacing: 0)
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(imageColor)
            
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
                    viewModel.fetchWeather()
                }
                .foregroundColor(.blue)
                .containerRelativeFrame(.horizontal, count: 4, spacing: 0)
            }
            .padding(.top, 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
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
