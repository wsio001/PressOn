//
//  StreakView.swift
//  PressOn
//
//  Created by William Sio on 7/09/25.
//

import SwiftUI

struct StreakView: View {
    @StateObject private var viewModel = StreakViewModel()
    var body: some View {
        GeometryReader { geometry in
            VStack {
                    // Main streak number display
                ZStack {
                    VStack(spacing: 20) {
                        Text("Current Streak")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                        
                        Text("\(viewModel.streak.count)")
                            .font(.system(size: 120, weight: .bold, design: .rounded))
                            .contentTransition(.numericText())
                        
                        // Streak message
                        Text(viewModel.getMessage())
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        Spacer()
                        
                        // Plus button
                        Button(action: {
                            viewModel.incrementStreak()
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 80, height: 80)
                                .background(
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [.blue, .blue.opacity(0.8)],
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                                )
                        }
                        .padding(.bottom, 80)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    StreakView()
}
