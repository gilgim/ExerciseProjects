//
//  Extension.swift
//  Router
//
//  Created by KimWooJin on 2022/12/20.
//

import Foundation
import SwiftUI

//  MARK: -Exention
//  MARK: Color
extension Color {
    static var colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple
                                  , .buttonBlue, .lightSeaGreen, .nickel, .marigold, .princetonOrange, .middleBluePurple]
    ///    - Korean : HexCode를 받기 위한 init
    ///    - English :
    init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
            }

            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue:  Double(b) / 255,
                opacity: Double(a) / 255
            )
        }
    // * 색상 모음 *
    static var lightGray: Color = .init(hex: "F7F7F7")
    static var buttonBlue: Color = .init(hex: "2da2e1")
    static var lightSeaGreen: Color = .init(hex: "18acb6")
    static var nickel: Color = .init(hex: "79716A")
    static var marigold: Color = .init(hex: "f1a81a")
    static var princetonOrange: Color = .init(hex: "f47d2e")
    static var middleBluePurple: Color = .init(hex: "886cc4")
}
