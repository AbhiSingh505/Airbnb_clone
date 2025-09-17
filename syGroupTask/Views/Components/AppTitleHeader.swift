import SwiftUI

struct AppTitleHeader: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        ZStack(alignment: .center) {
            LinearGradient(colors: [Color.indigo, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(0.85)
                .frame(height: 88)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.12))
                )
            HStack(spacing: 10) {
                Image(systemName: "sparkles")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(Color.white.opacity(0.85))
                }
            }
        }
        .shadow(color: Color.indigo.opacity(0.25), radius: 16, x: 0, y: 10)
        .padding(.horizontal)
    }
}
