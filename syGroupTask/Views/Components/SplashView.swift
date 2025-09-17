import SwiftUI

struct SplashView: View {
    var onFinish: () -> Void
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Theme.backgroundSecondary, Theme.background], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            HStack(spacing: 10) {
                Image(systemName: "sparkles")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                VStack(alignment: .leading, spacing: 2) {
                    Text("StaySphere")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .kerning(0.5)
                    Text("Stays & Experiences")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(Color.white.opacity(0.9))
                }
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(colors: [Color.indigo, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .shadow(color: Color.indigo.opacity(0.35), radius: 20, x: 0, y: 12)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.white.opacity(0.15))
            )
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    scale = 1.0
                    opacity = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        opacity = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        onFinish()
                    }
                }
            }
        }
    }
}
