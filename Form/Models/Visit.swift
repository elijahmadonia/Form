import Foundation

struct Visit: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let durationMinutes: Int
    let workoutsCompleted: Int
}
