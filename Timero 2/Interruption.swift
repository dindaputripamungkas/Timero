//
//  Interruption.swift
//  Timero 2
//
//  Created by Dinda Putri Pamungkas  on 22/04/26.
//

import SwiftUI

struct Interruption: View {
    @Environment(\.dismiss) var dismiss
    
    // Variable to track how many breaks have been completed
    @State var totalBreaksTaken: Int = 2
    @State var totalBreakMinutes: Int = 15
    
    var body: some View {
        ZStack {
            // Subtle Red Background to signal caution
            Color.red.opacity(0.05)
                .ignoresSafeArea()
            
            VStack(spacing: 35) {
                Spacer()
                
                // Warning Icon & Header
                VStack(spacing: 20) {
                    Image(systemName: "hand.raised.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.red)
                    
                    Text("Hold On!")
                        .font(.system(size: 32, weight: .black, design: .rounded))
                }
                
                // Session Statistics (The "Guilt Trip" Cards)
                HStack(spacing: 20) {
                    VStack {
                        Text("\(totalBreaksTaken)")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(.orange)
                        Text("Breaks Taken")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    .frame(width: 110, height: 90)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.05), radius: 10)
                    
                    VStack {
                        // Menampilkan total menit (misal: 15 mins)
                        Text("\(totalBreakMinutes)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.orange)
                        
                        Text("Mins Break")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    .frame(width: 110, height: 90)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.05), radius: 10)
                }
                
                Text("Don't let a momentary distraction ruin the momentum you've worked so hard to build.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                // Action Buttons
                VStack(spacing: 16) {
                    // Primary Action: Return to Focus
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Stay Focused")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    .shadow(color: .green.opacity(0.3), radius: 10, y: 5)
                    
                    // Secondary Action: Quit (Hidden/Subtle)
                    Button(action: {
                        // Logic to force quit or end session
                    }) {
                        Text("Ignore & Quit Anyway")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.red.opacity(0.8))
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    Interruption(totalBreaksTaken: 4)
}
