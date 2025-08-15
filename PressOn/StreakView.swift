//
//  StreakView.swift
//  PressOn
//
//  Created by William Sio on 7/09/25.
//

import SwiftUI

struct StreakView: View {
    @StateObject private var viewModel = StreakViewModel()
    @State private var scaleEffect: CGFloat = 1.0
    @State private var bounceAnimation = false
    @State private var showResetAlert = false
    @State private var plusAnimations: [PlusAnimation] = []
    
    private var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [Color(.systemBackground), Color(.systemGray6)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
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
                            .foregroundStyle(
                                LinearGradient(
                                    colors: viewModel.getStreakGradientColors(),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .scaleEffect(scaleEffect)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6), value: scaleEffect)
                            .contentTransition(.numericText())
                        
                        // Streak message
                        Text(viewModel.getMessage())
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    
                    // Plus sign animations
                    ForEach(plusAnimations, id: \.id) { animation in
                        Text("+")
                            .font(.system(size: 104, weight: .bold, design: .rounded))
                            .foregroundColor(animation.color)
                            .offset(x: animation.offsetX, y: animation.offsetY)
                            .opacity(animation.opacity)
                            .scaleEffect(animation.scale)
                            .animation(.easeOut(duration: 1.5), value: animation.offsetY)
                            .animation(.easeOut(duration: 1.5), value: animation.opacity)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: animation.scale)
                    }
                }
                .padding()
                
                // Plus button with water drop effect
                Button(action: {
                    viewModel.incrementStreak()
                    animateIncrement()
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
                        .scaleEffect(bounceAnimation ? 0.9 : 1.0)
                        .animation(.spring(response: 0.2, dampingFraction: 0.5), value: bounceAnimation)
                }
                .buttonStyle(WaterDropButtonStyle())
                .padding(.bottom, 80)
                
                Spacer()
            }
        }
        .background(backgroundGradient)
        .alert("Reset Streak", isPresented: $showResetAlert) {
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
    
    // MARK: - Private Methods
    private func animateIncrement() {
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
        
        // Button bounce animation
        bounceAnimation = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            bounceAnimation = false
        }
        
        // Number scale animation
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            scaleEffect = 1.2
        }
        
        // Reset scale
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                scaleEffect = 1.0
            }
        }
        
        // Add plus sign animation
        addPlusAnimation()
    }
    
    private func addPlusAnimation() {
        // Create multiple plus signs for a more dynamic effect
        let numberOfPluses = Int.random(in: 3...5)
        
        for i in 0..<numberOfPluses {
            let randomDelay = Double(i) * 0.1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
                let animation = PlusAnimation(
                    id: UUID(),
                    offsetX: Double.random(in: -80...80),
                    offsetY: 0,
                    targetY: Double.random(in: -120...(-60)),
                    opacity: 1.0,
                    scale: 0.5,
                    color: viewModel.getStreakGradientColors().randomElement() ?? .blue
                )
                
                plusAnimations.append(animation)
                
                // Start animation immediately
                withAnimation(.easeOut(duration: 1.5)) {
                    if let index = plusAnimations.firstIndex(where: { $0.id == animation.id }) {
                        plusAnimations[index].offsetY = animation.targetY
                        plusAnimations[index].opacity = 0.0
                        plusAnimations[index].scale = 1.2
                    }
                }
                
                // Remove animation after completion
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    plusAnimations.removeAll { $0.id == animation.id }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    StreakView()
}
