import Foundation

struct Exercise: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let equipment: String
    let sets: Int
    let reps: String
    let imageName: String?
}
