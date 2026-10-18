import SwiftUI

struct BreakTimerSheet: View {
    @State private var selectedMinutes = 5
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                Text("Take a break for...")
                    .font(.title2.bold())
                
                Picker("Select Minutes", selection: $selectedMinutes) {
                    ForEach(1...15, id: \.self) { minute in
                        Text("\(minute) minutes").tag(minute)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                .padding()
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Keep Focusing")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Start Break") {
                        //
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    BreakTimerSheet()
}
