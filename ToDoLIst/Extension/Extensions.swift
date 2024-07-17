//
//  Extensions.swift
//  ToDoLIst
//
//  Created by Dhruv's Macbook Pro  on 15/07/24.
//

import Foundation
import SwiftUI
import UIKit

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

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

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    init(light: Color, dark: Color) {
            #if canImport(UIKit)
            self.init(light: UIColor(light), dark: UIColor(dark))
            #else
            self.init(light: NSColor(light), dark: NSColor(dark))
            #endif
        }

        #if canImport(UIKit)
        init(light: UIColor, dark: UIColor) {
            #if os(watchOS)
            // watchOS does not support light mode / dark mode
            // Per Apple HIG, prefer dark-style interfaces
            self.init(uiColor: dark)
            #else
            self.init(uiColor: UIColor(dynamicProvider: { traits in
                switch traits.userInterfaceStyle {
                case .light, .unspecified:
                    return light

                case .dark:
                    return dark

                @unknown default:
                    assertionFailure("Unknown userInterfaceStyle: \(traits.userInterfaceStyle)")
                    return light
                }
            }))
            #endif
        }
        #endif

        #if canImport(AppKit)
        init(light: NSColor, dark: NSColor) {
            self.init(nsColor: NSColor(name: nil, dynamicProvider: { appearance in
                switch appearance.name {
                case .aqua,
                     .vibrantLight,
                     .accessibilityHighContrastAqua,
                     .accessibilityHighContrastVibrantLight:
                    return light

                case .darkAqua,
                     .vibrantDark,
                     .accessibilityHighContrastDarkAqua,
                     .accessibilityHighContrastVibrantDark:
                    return dark

                default:
                    assertionFailure("Unknown appearance: \(appearance.name)")
                    return light
                }
            }))
        }
        #endif
}
