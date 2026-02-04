import Foundation

struct LeaderboardEntry: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let visits: Int
    let workoutsCompleted: Int
    let isHereNow: Bool
}
