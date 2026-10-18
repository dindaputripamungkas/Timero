//
//  Extensions.swift
//  Timero 2
//
//  Created by Dinda Putri Pamungkas  on 23/04/26.
//

import Foundation
import SwiftUI

extension Color {
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
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

enum TimeroTheme {
    static let ink = Color(hex: "172033")
    static let mutedInk = Color(hex: "697386")
    static let surface = Color.white
    static let canvas = Color(hex: "F6F7FB")
    static let lavender = Color(hex: "E9E7FF")
    static let accent = Color(hex: "6256E8")
    static let accentDark = Color(hex: "4238B9")
    static let mint = Color(hex: "2BC48A")

    static let background = LinearGradient(
        colors: [Color(hex: "F9FAFF"), Color(hex: "F0EEFF")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

struct TimeroPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 17, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(
                    colors: [TimeroTheme.accent, TimeroTheme.accentDark],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .shadow(color: TimeroTheme.accent.opacity(configuration.isPressed ? 0.12 : 0.28), radius: 16, y: 8)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
