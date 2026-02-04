import SwiftUI

struct AppColors {
    static let background = Color(red: 0.06, green: 0.06, blue: 0.07)
    static let surface = Color(red: 0.12, green: 0.12, blue: 0.14)
    static let surfaceElevated = Color(red: 0.18, green: 0.18, blue: 0.2)
    static let primary = Color(red: 0.95, green: 0.96, blue: 0.97)
    static let accent = Color(red: 0.98, green: 0.35, blue: 0.65)
    static let accentMuted = Color(red: 0.68, green: 0.2, blue: 0.42)
    static let textPrimary = Color(red: 0.95, green: 0.96, blue: 0.97)
    static let textSecondary = Color(red: 0.68, green: 0.7, blue: 0.73)
    static let border = Color.white.opacity(0.12)
    static let tagBackground = Color(red: 0.2, green: 0.2, blue: 0.23)
    static let tagText = Color(red: 0.88, green: 0.9, blue: 0.92)
    static let cardShadow = Color.black.opacity(0.45)
    static let glow = Color.white.opacity(0.08)
}

struct AppTypography {
    static let title = Font.system(size: 30, weight: .bold, design: .rounded)
    static let headline = Font.system(size: 18, weight: .semibold, design: .rounded)
    static let body = Font.system(size: 16, weight: .regular, design: .rounded)
    static let caption = Font.system(size: 12, weight: .medium, design: .rounded)
}
