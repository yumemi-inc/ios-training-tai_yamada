//
//  WeatherView.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(.dummy)
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal, count: 2, spacing: 0)
                .aspectRatio(1, contentMode: .fit)
            
            HStack(spacing: 0) {
                Text("ー ー")
                    .foregroundColor(.blue)
                    .containerRelativeFrame(.horizontal, count: 4, spacing: 0)
                Text("ー ー")
                    .foregroundColor(.red)
                    .containerRelativeFrame(.horizontal, count: 4, spacing: 0)
            }
            
            HStack(spacing: 0) {
                // TODO: ボタンの機能は今後のタスクで実装する
                Button(action: {}) {
                    Text("Close")
                        .foregroundColor(.blue)
                        .containerRelativeFrame(.horizontal, count: 4, spacing: 0)
                }
                Button(action: {}) {
                    Text("Reload")
                        .foregroundColor(.blue)
                        .containerRelativeFrame(.horizontal, count: 4, spacing: 0)
                }
            }
            .padding(.top, 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    WeatherView()
}
