import SwiftUI

struct ShimmerSkeleton: View {
    var cornerRadius: CGFloat = 12
    var width: CGFloat? = nil
    var height: CGFloat = 16
    
    @State private var phase: CGFloat = -1
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(LinearGradient(gradient: Gradient(colors: [
                Color.gray.opacity(0.25),
                Color.gray.opacity(0.4),
                Color.gray.opacity(0.25)
            ]), startPoint: .leading, endPoint: .trailing))
            .frame(width: width, height: height)
            .mask(
                GeometryReader { proxy in
                    LinearGradient(gradient: Gradient(colors: [
                        Color.black.opacity(0.3),
                        Color.black,
                        Color.black.opacity(0.3)
                    ]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .offset(x: proxy.size.width * phase)
                }
            )
            .onAppear {
                withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    phase = 2
                }
            }
            .accessibilityLabel("Loading")
    }
}

#Preview {
    VStack(spacing: 12) {
        ShimmerSkeleton(width: 260, height: 18)
        ShimmerSkeleton(width: 200, height: 14)
        ShimmerSkeleton(width: 160, height: 14)
    }
    .padding()
}

