//
//  Weather.swift
//  ios-training-tai_yamada
//
//  Created by 山田 大陽 on 2025/10/15.
//

import SwiftUI
import Foundation

enum Weather: String {
    case sunny
    case cloudy
    case rainy

    var image: Image {
        switch self {
        case .sunny:  return Image(.sunny)
        case .cloudy: return Image(.cloudy)
        case .rainy:  return Image(.rainy)
        }
    }
}
