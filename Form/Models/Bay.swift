import Foundation

struct Bay: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let isOccupied: Bool
    let currentUsers: Int
}
