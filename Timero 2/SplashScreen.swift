import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var markAppeared = false

    var body: some View {
        Group {
            if isActive {
                OnBoardingView()
            } else {
                ZStack {
                    TimeroTheme.background.ignoresSafeArea()
                    Circle()
                        .fill(TimeroTheme.lavender.opacity(0.7))
                        .frame(width: 360, height: 360)
                        .blur(radius: 50)
                        .offset(x: 130, y: -260)

                    VStack(spacing: 22) {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 34, style: .continuous)
                                .fill(LinearGradient(colors: [TimeroTheme.accent, TimeroTheme.accentDark], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 116, height: 116)
                                .shadow(color: TimeroTheme.accent.opacity(0.3), radius: 28, y: 16)
                            Image(systemName: "timer")
                                .font(.system(size: 53, weight: .medium))
                                .foregroundStyle(.white)
                        }
                        .scaleEffect(markAppeared ? 1 : 0.82)
                        .opacity(markAppeared ? 1 : 0)

                        VStack(spacing: 10) {
                            Text("Timero")
                                .font(.system(size: 44, weight: .bold, design: .rounded))
                                .foregroundStyle(TimeroTheme.ink)
                            Text("Make room for deep work.")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundStyle(TimeroTheme.mutedInk)
                        }
                        .opacity(markAppeared ? 1 : 0)
                        Spacer()
                        HStack(spacing: 7) {
                            Circle().fill(TimeroTheme.accent).frame(width: 7, height: 7)
                            Text("YOUR FOCUS COMPANION")
                                .font(.system(size: 11, weight: .bold))
                                .tracking(1.4)
                                .foregroundStyle(TimeroTheme.mutedInk)
                        }
                        .padding(.bottom, 36)
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.65, dampingFraction: 0.72)) { markAppeared = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                withAnimation(.easeInOut(duration: 0.35)) { isActive = true }
            }
        }
    }
}

#Preview { SplashScreen() }
