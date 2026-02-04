import Foundation

struct Redeemable: Identifiable, Hashable {
    enum RedeemableType: String, Hashable {
        case merch
        case milkshake
    }

    let id = UUID()
    let title: String
    let type: RedeemableType
    let pointsCost: Int
    let cashPrice: String?
}
