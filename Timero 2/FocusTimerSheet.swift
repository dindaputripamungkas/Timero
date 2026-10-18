//  FocusTimerSheet.swift
//  Timero 2
//
//  Created by Dinda Putri Pamungkas  on 23/04/26.

//

import SwiftUI

struct FocusTimerSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var sessionName = ""
    @State private var focusDuration = Calendar.current.date(bySettingHour: 0, minute: 25, second: 0, of: Date()) ?? Date()
    @State private var selectedOption = "Social Media"
    
    let options = ["Social Media", "Games", "Streaming", "Shopping", "None"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Image(systemName: "pencil.line")
                            .foregroundColor(.green)
                        TextField("Study, Coding, or Reading...", text: $sessionName)
                    }
                } header: {
                    Text("Define Your Intent")
                        .font(.caption)
                        .fontWeight(.bold)
                } footer: {
                    Text("Setting a clear goal helps you stay on track.")
                }
                
                Section {
                    DatePicker(
                        "",
                        selection: $focusDuration,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
                } header: {
                    Label("Focus Duration", systemImage: "timer")
                        .bold()
                        .foregroundColor(.primary)
                }
                Section {
                    Picker(selection: $selectedOption) {
                        ForEach(options, id: \.self) { option in
                            Label(option, systemImage: iconForApp(option))
                                .tag(option)
                        }
                    } label: {
                        Label("Blocking Category", systemImage: "hand.raised.fill")
                            .foregroundColor(.primary)
                    }
                    .pickerStyle(.navigationLink)
                }
            }
            .navigationTitle("Ready to Focus?")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(.secondary)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                    }) {
                        Text("Start")
                            .bold()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(sessionName.isEmpty ? Color.gray.opacity(0.2) : Color.green)
                            .foregroundColor(sessionName.isEmpty ? .gray : .white)
                            .clipShape(Capsule())
                    }
                    .disabled(sessionName.isEmpty)
                }
            }
        }
    }
    
    func iconForApp(_ name: String) -> String {
        switch name {
        case "Social Media": return "person.2.fill"
        case "Games": return "gamecontroller.fill"
        case "Streaming": return "play.tv.fill"
        case "Shopping": return "cart.fill"
        default: return "app.badge.fill"
        }
    }
}

#Preview {
    FocusTimerSheet()
}
