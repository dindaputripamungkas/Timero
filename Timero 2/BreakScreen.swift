//
//  BreakScreen.swift
//  Timero 2
//
//  Created by Dinda Putri Pamungkas  on 23/04/26.
//

import SwiftUI
import Combine

struct MindfulDelayView: View {
    @Environment(\.dismiss) var dismiss
    @State private var secondsRemaining = 5
    @State private var isAnimating = false
    @State private var showNextButton = false
    
    // Timer untuk hitung mundur
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background konsisten (Hijau sangat tipis)
                Color.green.opacity(0.02)
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // Breathing Ring (Menggunakan Hijau yang sama dengan FocusTimer)
                    ZStack {
                        // Aura Cahaya (Glow)
                        Circle()
                            .stroke(Color.green.opacity(0.1), lineWidth: 2)
                            .scaleEffect(isAnimating ? 1.4 : 1.0)
                            .opacity(isAnimating ? 0 : 0.5)
                        
                        // Ring Utama
                        Circle()
                            .stroke(Color.green.opacity(0.2), lineWidth: 20)
                            .frame(width: 220, height: 220)
                        
                        // Circle yang "Bernapas"
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.green.opacity(0.6), Color(hex: "2ECC71").opacity(0.3)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 200, height: 200)
                            .scaleEffect(isAnimating ? 1.1 : 0.9)
                        
                        // Angka Hitung Mundur
                        Text("\(secondsRemaining)")
                            .font(.system(size: 60, weight: .bold, design: .monospaced))
                            .foregroundStyle(.green)
                            .opacity(secondsRemaining > 0 ? 1 : 0)
                    }
                    
                    VStack(spacing: 16) {
                        Text(secondsRemaining > 2 ? "Inhale deeply..." : "Exhale slowly...")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(.primary)
                        
                        Text("Pause for a moment to clear your mind.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 50)
                    }
                    
                    Spacer()
                    
                    // Tombol Konfirmasi (Muncul setelah timer habis)
                    if showNextButton {
                        Button(action: {
                            // Action: Tampilkan BreakTimerSheet
                            dismiss()
                        }) {
                            Text("Continue to Break")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                                .shadow(color: .green.opacity(0.3), radius: 10, y: 5)
                        }
                        .transition(.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity), removal: .opacity))
                        .padding(.horizontal, 30)
                    } else {
                        // Progress bar kecil sebagai indikator tambahan
                        ProgressView(value: Double(5 - secondsRemaining), total: 5)
                            .tint(.green)
                            .padding(.horizontal, 100)
                            .frame(height: 55)
                    }
                }
                .padding(.bottom, 30)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
            .onReceive(timer) { _ in
                if secondsRemaining > 0 {
                    withAnimation {
                        secondsRemaining -= 1
                    }
                } else {
                    withAnimation(.spring()) {
                        showNextButton = true
                    }
                }
            }
        }
    }
}

#Preview {
    MindfulDelayView()
}
