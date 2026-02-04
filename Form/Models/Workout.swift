import Foundation

struct Workout: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let durationMinutes: Int
    let difficulty: String
    let category: Category
    let exercises: [Exercise]
}
