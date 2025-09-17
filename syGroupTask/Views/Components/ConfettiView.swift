import SwiftUI

struct ConfettiView: View {
    @Binding var trigger: Bool
    let colors: [Color] = [.pink, .orange, .yellow, .green, .blue, .purple]
    
    var body: some View {
        ZStack {
            ForEach(0..<16, id: \.self) { i in
                Circle()
                    .fill(colors[i % colors.count])
                    .frame(width: 6, height: 6)
                    .opacity(trigger ? 1 : 0)
                    .offset(x: trigger ? CGFloat(Int.random(in: -80...80)) : 0,
                            y: trigger ? CGFloat(Int.random(in: -120...0)) : 0)
                    .rotationEffect(.degrees(trigger ? Double.random(in: 0...360) : 0))
                    .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(Double(i) * 0.01), value: trigger)
            }
        }
        .allowsHitTesting(false)
        .onChange(of: trigger) { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { trigger = false }
            }
        }
    }
}

