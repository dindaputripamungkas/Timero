//
//  Summary.swift
//  Timero 2
//
//  Created by Dinda Putri Pamungkas  on 23/04/26.
//

import SwiftUI

struct SummaryView: View {
    @Environment(\.dismiss) var dismiss
    
    // Data simulasi (nantinya dikirim dari FocusTimer)
    var taskName: String = "Deep Work Session"
    var totalFocusMinutes: Int = 25
    var totalBreaks: Int = 2
    var totalBreakMinutes: Int = 10
    
    var body: some View {
        ZStack {
            // Background konsisten
            Color.green.opacity(0.02)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Celebration Icon
                ZStack {
                    Circle()
                        .fill(Color.yellow.opacity(0.1))
                        .frame(width: 180, height: 180)
                        .blur(radius: 20)
                    
                    Image(systemName: "trophy.fill")
                        .symbolRenderingMode(.hierarchical)
                        .font(.system(size: 80))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.yellow, .orange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: .orange.opacity(0.3), radius: 15, y: 10)
                }
                
                // Title Section
                VStack(spacing: 8) {
                    Text("Session Complete!")
                        .font(.system(size: 32, weight: .black, design: .rounded))
                    
                    Text("Excellent work on \(taskName).")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                // Statistics Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    StatCard(title: "Focused", value: "\(totalFocusMinutes)", unit: "Mins", icon: "timer", color: .green)
                    StatCard(title: "Breaks", value: "\(totalBreaks)", unit: "Times", icon: "cup.and.saucer.fill", color: .blue)
                    StatCard(title: "Rest Time", value: "\(totalBreakMinutes)", unit: "Mins", icon: "zzz", color: .orange)
                    StatCard(title: "Efficiency", value: "92", unit: "%", icon: "chart.line.uptrend.xyaxis", color: .purple)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Action Button
                Button(action: {
                    dismiss()
                }) {
                    Text("Start Again")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [.green, Color(hex: "2ECC71")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(color: .green.opacity(0.3), radius: 10, y: 5)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
}

// Komponen Card Kecil untuk Statistik
struct StatCard: View {
    let title: String
    let value: String
    let unit: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundStyle(color)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .bottom, spacing: 4) {
                    Text(value)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text(unit)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 4)
                }
                
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    SummaryView()
}
