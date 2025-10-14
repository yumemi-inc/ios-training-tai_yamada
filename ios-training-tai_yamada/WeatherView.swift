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
                    .frame(width: geometry.size.width * 0.5) // 幅は画面の半分
                    .frame(height: geometry.size.width * 0.5) // 高さは幅と同じ
                    .frame(maxWidth: .infinity)
                    .clipped()

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
                    
                    Text("Reload")
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width * 0.25)
                    
                }
                .padding(.top, 80) // Labelとの隙間は80pt
                
            }
            .frame(maxHeight: .infinity, alignment: .center) // VStack全体を中央に
            

        }
    }
}

#Preview {
    WeatherView()
}
