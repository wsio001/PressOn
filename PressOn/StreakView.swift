//
//  StreakView.swift
//  PressOn
//
//  Created by William Sio on 7/09/25.
//

import SwiftUI

struct StreakView: View {
    @StateObject private var viewModel = StreakViewModel()
    @State private var showResetAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                // Header with reset button
                HStack {
                    Spacer()
                    Button("Reset") {
                        showResetAlert = true
                    }
                    .foregroundColor(.red)
                    .font(.system(size: 16, weight: .medium))
                }
                .padding(.horizontal, 30)
                .padding(.top, 20)
                
                Spacer()
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
        }.alert("Reset Streak", isPresented: $showResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    viewModel.resetStreak()
                }
            }
        } message: {
            Text("Are you sure you want to reset your streak to 0?")
        }
    }
}

#Preview {
    StreakView()
}
