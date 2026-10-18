import SwiftUI

struct OnBoardingView: View {
    @State private var currentPage = 0
    @State private var hasStarted = false

    private let pages = [
        OnboardingPage(icon: "scope", eyebrow: "A calmer way to work", title: "Protect your\nbest attention.", detail: "Set one meaningful intention and let the rest of the day get quieter."),
        OnboardingPage(icon: "bell.slash.fill", eyebrow: "Less noise, more progress", title: "Keep distractions\nin their place.", detail: "Create a focused pocket of time for the work that moves you forward.")
    ]

    var body: some View {
        if hasStarted {
            FocusTimer()
        } else {
            ZStack {
                TimeroTheme.background.ignoresSafeArea()
                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                        OnboardingPageView(page: page).tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                VStack {
                    HStack {
                        Text("Timero")
                            .font(.system(size: 23, weight: .bold, design: .rounded))
                            .foregroundStyle(TimeroTheme.ink)
                        Spacer()
                        Button("Skip") { withAnimation { hasStarted = true } }
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(TimeroTheme.mutedInk)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 12)
                    Spacer()
                    HStack(spacing: 7) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Capsule()
                                .fill(index == currentPage ? TimeroTheme.accent : TimeroTheme.accent.opacity(0.16))
                                .frame(width: index == currentPage ? 28 : 8, height: 8)
                        }
                    }
                    .animation(.spring(response: 0.35), value: currentPage)
                    Button(currentPage == pages.count - 1 ? "Start focusing" : "Continue") {
                        withAnimation {
                            if currentPage == pages.count - 1 { hasStarted = true }
                            else { currentPage += 1 }
                        }
                    }
                    .buttonStyle(TimeroPrimaryButtonStyle())
                    .padding(.top, 24)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 26)
                }
            }
        }
    }
}

private struct OnboardingPage {
    let icon: String
    let eyebrow: String
    let title: String
    let detail: String
}

private struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 130)
            ZStack {
                Circle().fill(TimeroTheme.lavender).frame(width: 250, height: 250)
                Circle().stroke(.white.opacity(0.75), lineWidth: 14).frame(width: 192, height: 192)
                Image(systemName: page.icon)
                    .font(.system(size: 74, weight: .medium))
                    .foregroundStyle(LinearGradient(colors: [TimeroTheme.accent, TimeroTheme.accentDark], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
            .frame(maxWidth: .infinity)
            Spacer()
            Text(page.eyebrow.uppercased())
                .font(.system(size: 12, weight: .bold))
                .tracking(1.3)
                .foregroundStyle(TimeroTheme.accent)
            Text(page.title)
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundStyle(TimeroTheme.ink)
                .padding(.top, 10)
            Text(page.detail)
                .font(.system(size: 17))
                .foregroundStyle(TimeroTheme.mutedInk)
                .lineSpacing(4)
                .padding(.top, 14)
                .padding(.trailing, 24)
            Spacer().frame(height: 170)
        }
        .padding(.horizontal, 24)
    }
}

#Preview { OnBoardingView() }
