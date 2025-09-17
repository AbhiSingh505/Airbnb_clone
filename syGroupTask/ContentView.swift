//
//  ContentView.swift
//  syGroupTask
//
//  Created by Amritesh Kumar on 02/09/25.
//

 import SwiftUI

 struct ContentView: View {
    enum Tab: Int, CaseIterable, Identifiable {
        case explore, wishlist, trips, messages, profile
        var id: Int { rawValue }
        var title: String {
            switch self {
            case .explore: return "Explore"
            case .wishlist: return "Wishlists"
            case .trips: return "Trips"
            case .messages: return "Messages"
            case .profile: return "Profile"
            }
        }
        var systemImageName: String? {
            switch self {
            case .explore: return "magnifyingglass"
            case .wishlist: return "heart"
            case .trips: return nil // Uses brand image
            case .messages: return "bubble.left"
            case .profile: return "person.circle"
            }
        }
    }
    
    @Namespace private var tabSelectionAnimation
    @State private var selectedTab: Tab = .explore
    @State private var explorePath = NavigationPath()
    @State private var isTabBarHidden: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(colors: [Theme.background, Theme.backgroundSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case .explore:
                        NavigationStack(path: $explorePath) { ExploreView() }
                    case .wishlist:
                        NavigationStack { WishlistView() }
                    case .trips:
                        NavigationStack { TripsView() }
                    case .messages:
                        NavigationStack { MessagesView() }
                    case .profile:
                        NavigationStack { ProfileViews() }
                    }
                }
                .onPreferenceChange(TabBarVisibilityKey.self) { hidden in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isTabBarHidden = hidden
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            Group {
                if !isTabBarHidden {
                    CustomTabBar(selectedTab: $selectedTab, namespace: tabSelectionAnimation)
                        .padding(.horizontal, 12)
                        .padding(.bottom, 12)
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .scale(scale: 0.95)).combined(with: .opacity),
                            removal: .move(edge: .bottom).combined(with: .opacity)
                        ))
                }
            }
            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: isTabBarHidden)
        }
        .tint(Theme.warning)
    }
}

#Preview {
    ContentView()
}
