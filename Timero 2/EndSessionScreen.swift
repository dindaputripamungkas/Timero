//
//  EndSessionScreen.swift
//  Timero 2
//
//  Created by Dinda Putri Pamungkas  on 23/04/26.
//

import SwiftUI

struct EndSessionScreen: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var progress: CGFloat = 0.0
    @GestureState private var isHoldingGesture = false
    
    private let duration: CGFloat = 3.0

    var body: some View {
        VStack {
            Spacer()
            
            HoldToEndComponent(
                holdProgress: $progress,
                isHolding: isHoldingGesture
            )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .updating($isHoldingGesture) { _, state, _ in
                        state = true
                    }
                    .onChanged { _ in
                        withAnimation(.linear(duration: duration)) {
                            progress = 1.0
                        }
                    }
                    .onEnded { _ in
                        if progress < 1.0 {
                            withAnimation(.easeInOut) {
                                progress = 0
                            }
                        } else {
                            // Aksi ketika sukses penuh
                            print("Session Ended!")
                            dismiss()
                        }
                    }
            )
            
            Spacer()
            
            Button("Cancel") {
                dismiss()
            }
            .buttonStyle(.bordered)
            .tint(.blue)
        }
        .padding(40)
    }
}

// --- 2. KOMPONEN VISUAL (UI SAJA) ---
// Kita beri nama sedikit berbeda agar tidak bentrok
struct HoldToEndComponent: View {
    @Binding var holdProgress: CGFloat
    var isHolding: Bool

    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                Text("End Session?")
                    .font(.title.bold())
                    .foregroundStyle(.red)
                Text("Hold the button to confirm.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            ZStack {
                // Background Circle
                Circle()
                    .stroke(Color.red.opacity(0.1), lineWidth: 10)
                    .frame(width: 120, height: 120)
                
                // Progress Circle
                Circle()
                    .trim(from: 0, to: holdProgress)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                
                // Icon Tengah
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.red)
            }
            .scaleEffect(isHolding ? 1.2 : 1.0)
            .animation(.spring(), value: isHolding)
            
            Text("Keep holding to quit")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// --- 3. PREVIEW ---
#Preview {
    EndSessionScreen()
}
