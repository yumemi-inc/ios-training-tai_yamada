//
//  ContentView.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/14.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Image("dummy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)

                HStack(spacing: 0) {
                    Text("ー ー")
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width * 0.25)
                    Text("ー ー")
                        .foregroundColor(.red)
                        .frame(width: geometry.size.width * 0.25)
                }
                
                HStack(spacing: 0) {
                    // ボタンの機能は今後のタスクで実装する
                    Button(action: {}) {
                        Text("Close")
                            .foregroundColor(.blue)
                            .frame(width: geometry.size.width * 0.25)
                    }
                    Button(action: {}) {
                        Text("Reload")
                            .foregroundColor(.blue)
                            .frame(width: geometry.size.width * 0.25)
                    }
                }
                .padding(.top, 80)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

#Preview {
    WeatherView()
}
