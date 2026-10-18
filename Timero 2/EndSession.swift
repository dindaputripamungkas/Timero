//
//  EndSession.swift
//  Timero 2
//
//  Created by Dinda Putri Pamungkas  on 23/04/26.
//

import SwiftUI
import Combine

struct EndSession: View {
    @Environment(\.dismiss) var dismiss
    @State private var holdProgress: CGFloat = 0.0
    @State private var isHolding = false
    @State private var showFinalChoice = false
    
    // Timer untuk mendeteksi durasi hold
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let holdDuration: CGFloat = 3.0 // Perlu 3 detik untuk hold
    
    var body: some View {
        ZStack {
            // Background Merah Konsisten (Vibe Bahaya/Berhenti)
            Color.red.opacity(0.05).ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Icon & Text
                VStack(spacing: 20) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.red)
                    
                    Text("Quitting So Soon?")
                        .font(.system(size: 32, weight: .black, design: .rounded))
                    
                    Text("Momentum is hard to build but easy to lose. Are you sure you want to end this session?")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                // HOLD BUTTON AREA
                VStack(spacing: 20) {
                    Text(isHolding ? "Keep holding..." : "Hold to end session")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                    
                    ZStack {
                        // Background Circle
                        Circle()
                            .stroke(Color.red.opacity(0.1), lineWidth: 10)
                            .frame(width: 120, height: 120)
                        
                        // Progress Circle (Hold Indicator)
                        Circle()
                            .trim(from: 0.0, to: holdProgress / holdDuration)
                            .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .frame(width: 120, height: 120)
                            .rotationEffect(Angle(degrees: -90))
                        
                        // Central Button Icon
                        Image(systemName: "power")
                            .font(.title.bold())
                            .foregroundStyle(isHolding ? .red : .secondary)
                    }
                    // GESTURE RECOGNIZER
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                isHolding = true
                            }
                            .onEnded { _ in
                                isHolding = false
                                if holdProgress < holdDuration {
                                    holdProgress = 0 // Reset jika dilepas sebelum penuh
                                }
                            }
                    )
                }
                
                Spacer()
                
                // Tombol Batal (Paling Menonjol)
                Button(action: { dismiss() }) {
                    Text("Nevermind, I'll keep going")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
        }
        // Logika Timer untuk menaikkan progress saat di-hold
        .onReceive(timer) { _ in
            if isHolding && holdProgress < holdDuration {
                holdProgress += 0.1
                if holdProgress >= holdDuration {
                    isHolding = false
                    showFinalChoice = true // Pemicu Pop-up
                }
            }
        }
        // POP-UP KONFIRMASI AKHIR
        .confirmationDialog("What would you like to do?", isPresented: $showFinalChoice, titleVisibility: .visible) {
            Button("End Session Anyway", role: .destructive) {
                // Action: Benar-benar tutup aplikasi/sesi
            }
            Button("Take a Break Instead") {
                // Action: Arahkan ke MindfulDelayView atau BreakTimerSheet
                dismiss()
            }
            Button("Cancel", role: .cancel) {
                holdProgress = 0
            }
        } message: {
            Text("Maybe you just need a short rest instead of stopping entirely?")
        }
    }
}

#Preview {
    EndSession()
}
