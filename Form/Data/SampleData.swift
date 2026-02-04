import Foundation

struct SampleData {
    static let workouts: [Workout] = [
        Workout(
            title: "Hip Flow",
            durationMinutes: 18,
            difficulty: "Easy",
            category: .mobility,
            exercises: [
                Exercise(name: "90/90 Switches", equipment: "Bodyweight", sets: 2, reps: "8/side", imageName: "exercise_9090_switches"),
                Exercise(name: "World's Greatest Stretch", equipment: "Bodyweight", sets: 2, reps: "5/side", imageName: "exercise_worlds_greatest_stretch"),
                Exercise(name: "Cossack Squat", equipment: "Bodyweight", sets: 2, reps: "6/side", imageName: "exercise_cossack_squat")
            ]
        ),
        Workout(
            title: "Lower Body Strength",
            durationMinutes: 42,
            difficulty: "Moderate",
            category: .strength,
            exercises: [
                Exercise(name: "Back Squat", equipment: "Barbell", sets: 4, reps: "6", imageName: "exercise_back_squat"),
                Exercise(name: "RDL", equipment: "Barbell", sets: 3, reps: "8", imageName: "exercise_rdl"),
                Exercise(name: "Walking Lunge", equipment: "Dumbbells", sets: 3, reps: "10/side", imageName: "exercise_walking_lunge")
            ]
        ),
        Workout(
            title: "Intervals 20/10",
            durationMinutes: 25,
            difficulty: "Hard",
            category: .cardio,
            exercises: [
                Exercise(name: "Assault Bike", equipment: "Bike", sets: 10, reps: "20s on / 10s off", imageName: "exercise_assault_bike"),
                Exercise(name: "Row", equipment: "Rower", sets: 6, reps: "250m", imageName: "exercise_row"),
                Exercise(name: "Cooldown Walk", equipment: "Treadmill", sets: 1, reps: "5 min", imageName: "exercise_cooldown_walk")
            ]
        ),
        Workout(
            title: "Kettlebell Builder",
            durationMinutes: 30,
            difficulty: "Moderate",
            category: .equipment,
            exercises: [
                Exercise(name: "KB Swing", equipment: "Kettlebell", sets: 4, reps: "15", imageName: "exercise_kb_swing"),
                Exercise(name: "Goblet Squat", equipment: "Kettlebell", sets: 3, reps: "12", imageName: "exercise_goblet_squat"),
                Exercise(name: "Farmer Carry", equipment: "Kettlebells", sets: 4, reps: "40m", imageName: "exercise_farmer_carry")
            ]
        )
    ]

    static let bays: [Bay] = [
        Bay(name: "1", isOccupied: true, currentUsers: 2),
        Bay(name: "2", isOccupied: false, currentUsers: 0),
        Bay(name: "3", isOccupied: true, currentUsers: 1),
        Bay(name: "4", isOccupied: false, currentUsers: 0),
        Bay(name: "5", isOccupied: true, currentUsers: 3),
        Bay(name: "6", isOccupied: false, currentUsers: 0),
        Bay(name: "7", isOccupied: false, currentUsers: 0),
        Bay(name: "8", isOccupied: true, currentUsers: 2),
        Bay(name: "9", isOccupied: false, currentUsers: 0),
        Bay(name: "10", isOccupied: true, currentUsers: 1),
        Bay(name: "11", isOccupied: false, currentUsers: 0),
        Bay(name: "12", isOccupied: true, currentUsers: 2),
        Bay(name: "13", isOccupied: false, currentUsers: 0),
        Bay(name: "14", isOccupied: true, currentUsers: 2)
    ]

    static let gymStatus = GymStatus(
        totalBays: 14,
        availableBays: 7,
        occupiedBays: 7,
        peopleInGym: 22
    )

    static let visits: [Visit] = [
        Visit(date: Date().addingTimeInterval(-86400 * 1), durationMinutes: 62, workoutsCompleted: 2),
        Visit(date: Date().addingTimeInterval(-86400 * 3), durationMinutes: 45, workoutsCompleted: 1),
        Visit(date: Date().addingTimeInterval(-86400 * 5), durationMinutes: 70, workoutsCompleted: 2),
        Visit(date: Date().addingTimeInterval(-86400 * 8), durationMinutes: 38, workoutsCompleted: 1),
        Visit(date: Date().addingTimeInterval(-86400 * 11), durationMinutes: 52, workoutsCompleted: 2)
    ]

    static let leaderboard: [LeaderboardEntry] = [
        LeaderboardEntry(name: "Jordan", visits: 18, workoutsCompleted: 32, isHereNow: true),
        LeaderboardEntry(name: "Taylor", visits: 15, workoutsCompleted: 28, isHereNow: false),
        LeaderboardEntry(name: "Casey", visits: 12, workoutsCompleted: 24, isHereNow: true),
        LeaderboardEntry(name: "Morgan", visits: 10, workoutsCompleted: 21, isHereNow: false)
    ]

    static let points = PointsAccount(balance: 420, lifetimeEarned: 1280)

    static let membership = Membership(
        planName: "Unlimited",
        renewalDate: Calendar.current.date(byAdding: .day, value: 14, to: Date()) ?? Date(),
        status: "Active"
    )

    static let redeemables: [Redeemable] = [
        Redeemable(title: "Protein Milkshake", type: .milkshake, pointsCost: 120, cashPrice: "$6"),
        Redeemable(title: "Classic Tee", type: .merch, pointsCost: 300, cashPrice: "$25"),
        Redeemable(title: "Crew Socks", type: .merch, pointsCost: 150, cashPrice: "$12"),
        Redeemable(title: "Shaker Bottle", type: .merch, pointsCost: 220, cashPrice: "$18")
    ]
}
