import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: ContentView.Tab
    var namespace: Namespace.ID
    
    private struct TabItem: Identifiable {
        let id = UUID()
        let tab: ContentView.Tab
        let title: String
        let systemImageName: String?
        let isBrandImage: Bool
    }
    
    private var items: [TabItem] {
        [
            TabItem(tab: .explore, title: ContentView.Tab.explore.title, systemImageName: ContentView.Tab.explore.systemImageName, isBrandImage: false),
            TabItem(tab: .wishlist, title: ContentView.Tab.wishlist.title, systemImageName: ContentView.Tab.wishlist.systemImageName, isBrandImage: false),
            TabItem(tab: .trips, title: ContentView.Tab.trips.title, systemImageName: nil, isBrandImage: true),
            TabItem(tab: .messages, title: ContentView.Tab.messages.title, systemImageName: ContentView.Tab.messages.systemImageName, isBrandImage: false),
            TabItem(tab: .profile, title: ContentView.Tab.profile.title, systemImageName: ContentView.Tab.profile.systemImageName, isBrandImage: false)
        ]
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(items) { item in
                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                        selectedTab = item.tab
                    }
                    Haptics.selectionChanged()
                } label: {
                    VStack(spacing: 6) {
                        ZStack {
                            if item.isBrandImage {
                                Image("Airbnb")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: item.tab == .trips ? 28 : 20, height: item.tab == .trips ? 28 : 20)
                            } else if let name = item.systemImageName {
                                Image(systemName: name)
                                    .font(.system(size: item.tab == .trips ? 22 : 18, weight: .semibold))
                            }
                        }
                        .frame(height: 24)
                        
                        Text(item.title)
                            .font(.system(size: 11, weight: selectedTab == item.tab ? .semibold : .regular))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, item.tab == .trips ? 14 : 10)
                    .foregroundColor(selectedTab == item.tab ? Theme.textLight : Theme.textPrimary)
                    .background(
                        ZStack {
                            if selectedTab == item.tab {
                                RoundedRectangle(cornerRadius: item.tab == .trips ? 18 : 12)
                                    .fill(LinearGradient(colors: [Theme.primaryColor, Color.pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .matchedGeometryEffect(id: "TAB_BG", in: namespace)
                                    .shadow(color: Theme.cardShadow, radius: 10, x: 0, y: 6)
                            }
                        }
                    )
                }
            }
        }
        .padding(8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: Theme.cardShadow, radius: 12, x: 0, y: 6)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

