import SwiftUI

struct FocusTimer: View {
    @State private var remainingSeconds = 25 * 60
    @State private var isPaused = false

    private var progress: CGFloat { CGFloat(remainingSeconds) / CGFloat(25 * 60) }
    private var timeString: String {
        String(format: "%02d:%02d", remainingSeconds / 60, remainingSeconds % 60)
    }

    var body: some View {
        ZStack {
            TimeroTheme.background.ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("MONDAY, 22 APRIL")
                            .font(.system(size: 11, weight: .bold))
                            .tracking(1.1)
                            .foregroundStyle(TimeroTheme.mutedInk)
                        Text("Good morning")
                            .font(.system(size: 27, weight: .bold, design: .rounded))
                            .foregroundStyle(TimeroTheme.ink)
                    }
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 39))
                        .foregroundStyle(TimeroTheme.accent.opacity(0.85))
                }
                .padding(.top, 18)

                HStack(spacing: 8) {
                    Circle().fill(isPaused ? Color.orange : TimeroTheme.mint).frame(width: 8, height: 8)
                    Text(isPaused ? "SESSION PAUSED" : "IN FOCUS MODE")
                        .font(.system(size: 12, weight: .bold))
                        .tracking(1.1)
                }
                .foregroundStyle(TimeroTheme.ink)
                .padding(.horizontal, 14)
                .padding(.vertical, 9)
                .background(.white.opacity(0.72))
                .clipShape(Capsule())
                .padding(.top, 36)

                ZStack {
                    Circle().fill(TimeroTheme.lavender.opacity(0.55)).frame(width: 286, height: 286)
                    Circle().stroke(.white, lineWidth: 15).frame(width: 244, height: 244)
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            LinearGradient(colors: [TimeroTheme.accent, Color(hex: "A78BFA")], startPoint: .topLeading, endPoint: .bottomTrailing),
                            style: StrokeStyle(lineWidth: 15, lineCap: .round)
                        )
                        .frame(width: 244, height: 244)
                        .rotationEffect(.degrees(-90))
                        .shadow(color: TimeroTheme.accent.opacity(0.25), radius: 12, y: 6)
                    VStack(spacing: 9) {
                        Text(timeString)
                            .font(.system(size: 52, weight: .bold, design: .rounded))
                            .monospacedDigit()
                            .foregroundStyle(TimeroTheme.ink)
                        Text("remaining")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(TimeroTheme.mutedInk)
                    }
                }
                .padding(.top, 34)

                Text("Write project proposal")
                    .font(.system(size: 21, weight: .bold, design: .rounded))
                    .foregroundStyle(TimeroTheme.ink)
                    .padding(.top, 28)
                Text("One thing at a time. You’ve got this.")
                    .font(.system(size: 15))
                    .foregroundStyle(TimeroTheme.mutedInk)
                    .padding(.top, 5)
                Spacer()
                Button { isPaused.toggle() } label: {
                    Label(isPaused ? "Resume session" : "Pause session", systemImage: isPaused ? "play.fill" : "pause.fill")
                }
                .buttonStyle(TimeroPrimaryButtonStyle())
                Button("End session") { }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(TimeroTheme.mutedInk)
                    .padding(.top, 18)
                    .padding(.bottom, 18)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview { FocusTimer() }
