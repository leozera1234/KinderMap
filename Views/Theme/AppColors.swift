import SwiftUI

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension Color {
    static let appPrimary = Color(red: 0.25, green: 0.32, blue: 0.71) // Deep Indigo
    static let appSecondary = Color(red: 0.14, green: 0.64, blue: 0.61) // Teal
    static let appAccent = Color(red: 0.96, green: 0.44, blue: 0.51) // Rose

    static var appSystemBackground: Color {
        #if os(macOS)
        return Color(nsColor: .windowBackgroundColor)
        #else
        return Color(uiColor: .systemBackground)
        #endif
    }

    static var appSecondaryBackground: Color {
        #if os(macOS)
        return Color(nsColor: .controlBackgroundColor)
        #else
        return Color(uiColor: .secondarySystemBackground)
        #endif
    }

    static var appTertiaryFill: Color {
        #if os(macOS)
        return Color(nsColor: .quaternaryLabelColor).opacity(0.3)
        #else
        return Color(uiColor: .tertiarySystemFill)
        #endif
    }
}
