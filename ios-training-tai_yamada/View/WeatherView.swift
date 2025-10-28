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
                case .idle:
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                        
                        Text("更新をお試しください")
                            .foregroundStyle(.gray)
                    }
                    .aspectRatio(1, contentMode: .fit)
                    
                case .loading:
                    ProgressView()
                        .tint(.gray)
                        .aspectRatio(1, contentMode: .fit)

                case .success(let weatherInfo):
                    weatherInfo.condition.image
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(weatherInfo.condition.color)

                case .failure:
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                }
            }
            .containerRelativeFrame(.horizontal, count: 2, spacing: 0)
            
            HStack(spacing: 0) {
                Text(minTempText)
                    .foregroundColor(.blue)
                    .font(.system(size: 35, weight: .light))
                    .containerRelativeFrame(.horizontal, count: 4, spacing: 0)
                Text(maxTempText)
                    .foregroundColor(.red)
                    .font(.system(size: 35, weight: .light))
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
        .alert("エラー",
               isPresented: .constant(viewModel.error != nil),
               actions: {
                   Button("OK", role: .cancel) {
                       viewModel.dismissError()
                   }
               },
               message: {
                   Text(viewModel.error?.localizedDescription ?? "")
               })
    }
    
    private var minTempText: String {
        if case .success(let info) = viewModel.state {
            return "\(info.minTemp)"
        }
        return "ー ー"
    }

    private var maxTempText: String {
        if case .success(let info) = viewModel.state {
            return "\(info.maxTemp)"
        }
        return "ー ー"
    }
}

#Preview {
    WeatherView()
}
