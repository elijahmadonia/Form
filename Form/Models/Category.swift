import SwiftUI

enum Category: String, CaseIterable, Identifiable {
    case mobility
    case strength
    case cardio
    case equipment

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .mobility: return "Mobility"
        case .strength: return "Strength"
        case .cardio: return "Cardio"
        case .equipment: return "Equipment"
        }
    }

    var color: Color {
        switch self {
        case .mobility: return Color(red: 0.2, green: 0.54, blue: 0.46)
        case .strength: return Color(red: 0.35, green: 0.3, blue: 0.2)
        case .cardio: return Color(red: 0.68, green: 0.22, blue: 0.24)
        case .equipment: return Color(red: 0.2, green: 0.33, blue: 0.55)
        }
    }
}
