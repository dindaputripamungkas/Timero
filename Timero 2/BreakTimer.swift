//
//  BreakTimer.swift
//  Timero 2
//
//  Created by Dinda Putri Pamungkas  on 22/04/26.
//

import SwiftUI

struct BreakTimer: View {
    @State private var progress = 0.8
    @State private var breakCount = 1
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background sangat tipis untuk membedakan dengan Focus Mode
                Color.red.opacity(0.02)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Status Header
                    VStack(spacing: 12) {
                        HStack(spacing: 6) {
                            Circle()
                                .fill(.red)
                                .frame(width: 8, height: 8)
                            
                            Text("BREAK #\(breakCount)")
                                .font(.system(size: 14, weight: .black))
                                .tracking(2)
                        }
                        .foregroundStyle(.red)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(Color.red.opacity(0.1))
                        .clipShape(Capsule())
                        
                        Text("Paused for a moment")
                            .font(.system(size: 24, weight: .medium, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    // Break Progress Ring
                    ZStack {
                        // Outer Glow
                        Circle()
                            .stroke(Color.red.opacity(0.05), lineWidth: 25)
                        
                        // Track
                        Circle()
                            .stroke(Color.red.opacity(0.1), lineWidth: 15)
                        
                        // Progress
                        Circle()
                            .trim(from: 0.0, to: progress)
                            .stroke(
                                LinearGradient(
                                    colors: [.red.opacity(0.8), .orange.opacity(0.6)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                style: StrokeStyle(lineWidth: 15, lineCap: .round)
                            )
                            .rotationEffect(Angle(degrees: -90))
                            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: progress)
                        
                        VStack(spacing: 5) {
                            Text(Date(), style: .timer)
                                .font(.system(size: 65, weight: .bold, design: .monospaced))
                                .contentTransition(.numericText())
                            
                            Text("away from focus")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(.red.opacity(0.6))
                        }
                    }
                    .padding(50)
                    
                    Spacer()
                    
                    // Return Button: Dibuat PALING menonjol agar user ingin segera kembali
                    Button(action: {
                        // Action to return
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "play.fill")
                            Text("Return to Focus")
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [.green, Color(hex: "2ECC71")],
                                startPoint: .leading,
                                endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(color: .green.opacity(0.4), radius: 15, x: 0, y: 8)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                }
                .padding()
            }
        }
    }
}

#Preview {
    BreakTimer()
}
