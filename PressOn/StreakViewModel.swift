//
//  streakViewModel.swift
//  test
//
//  Created by William Sio on 7/09/25.
//

import Foundation
import SwiftUI

class StreakViewModel: ObservableObject {
    @Published var streak: Streak
    private let userDefaults = UserDefaults.standard
    private let streakKey = "streakCount"
    
    init() {
        let savedCount = userDefaults.integer(forKey: streakKey)
        self.streak = Streak(count: savedCount)
    }
    
    func incrementStreak() {
        streak.count += 1
        saveStreak()
    }
    
    func resetStreak() {
        streak.count = 0
        saveStreak()
    }
    
    func getMessage() -> String {
        switch streak.count {
        case 0:
            return "Start your press on journey!"
        case 1...3:
            return "Great start! Keep it up! 🌱"
        case 4...7:
            return "You're building momentum! 🔥"
        case 8...14:
            return "Incredible consistency! 🚀"
        case 15...30:
            return "You're on fire! Amazing dedication! ⭐"
        case 31...99:
            return "Streak master! Absolutely incredible! 👑"
        default:
            return "LEGENDARY STATUS ACHIEVED! 🏆✨"
        }
    }
    
    func getStreakGradientColors() -> [Color] {
        switch streak.count {
        case 0...7:
            return [.blue, .purple]
        case 8...14:
            return [.green, .blue]
        case 15...30:
            return [.orange, .red]
        default:
            return [.pink, .purple, .blue]
        }
    }
    
    private func saveStreak() {
        userDefaults.set(streak.count, forKey: streakKey)
    }
}
