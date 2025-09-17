//
//  ExploreView.swift
//  syGroupTask
//
//  Created by Amritesh Kumar on 02/09/25.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var selectedFilter: String = "Homes"
    @State private var scrollOffset: CGFloat = 0
    
    let filters = ["Homes", "Experience", "Services"]

    var body: some View {
        ZStack(alignment: .top) {
            Theme.background.ignoresSafeArea()
            VStack(spacing: 22) {
                
                // Search Bar
                Button {
                    isSearching = true
                } label: {
                    SearchBarView(searchText: $searchText)
                }
                .fullScreenCover(isPresented: $isSearching) {
                    SearchView(isSearching: $isSearching)
                }

                // Top Filter Tabs
                HStack(spacing: 12) {
                    Button {
                        isSearching = false
                    } label: {
                        EmptyView()
                    }
                    ForEach(filters, id: \.self) { filter in
                        Button {
                            selectedFilter = filter
                        } label: {
                            Text(filter)
                                .font(.system(size: 15, weight: selectedFilter == filter ? .semibold : .regular))
                                .foregroundColor(selectedFilter == filter ? Theme.textLight : Theme.textPrimary)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(
                                    Group {
                                        if selectedFilter == filter {
                                            LinearGradient(colors: [Theme.primaryColor, Color.pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                                                .clipShape(Capsule())
                                        } else {
                                            Capsule().fill(Theme.backgroundSecondary)
                                        }
                                    }
                                )
                        }
                    }
                }
                .padding(.horizontal)
                
                // Map Explore CTA
                HStack {
                    Spacer()
                    NavigationLink {
                        MapExploreView()
                            .toolbar(.hidden, for: .tabBar)
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "map")
                            Text("Map Explore")
                                .fontWeight(.semibold)
                        }
                        .font(.system(size: 14))
                        .foregroundColor(Theme.textPrimary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                        .shadow(color: Theme.cardShadow, radius: 8, x: 0, y: 4)
                    }
                }
                .padding(.horizontal)

                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {
                        if selectedFilter == "Homes" {
                            homesSection
                        } else if selectedFilter == "Experience" {
                            experiencesSection
                        } else if selectedFilter == "Services" {
                            servicesSection
                        }
                    }
                    .background(
                        GeometryReader { proxy in
                            let minY = proxy.frame(in: .named("ExploreScroll")).minY
                            Color.clear.preference(key: ExploreScrollOffsetKey.self, value: -minY)
                        }
                    )
                }
                .coordinateSpace(name: "ExploreScroll")
                .onPreferenceChange(ExploreScrollOffsetKey.self) { value in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        scrollOffset = value
                    }
                }
                
                Spacer()
            }
            .padding(.top, 6)
            
            // Dynamic Top Bar Overlay
            topBar
                .opacity(min(max(scrollOffset / 60, 0), 1))
                .animation(.easeInOut(duration: 0.2), value: scrollOffset)
        }
    }

    // MARK: - Different Sections
    var homesSection: some View {
        VStack(alignment: .leading, spacing: 26) {
            VStack(alignment: .leading, spacing: 10) {
                NavigationLink {
                    RecentlyViewedHomesView()
                        .toolbar(.hidden, for: .tabBar)
                } label: {
                    HStack {
                        Text("Recently viewed homes")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Theme.textPrimary)
                            .lineLimit(1)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Theme.textPrimary)
                    }
                    .padding(.horizontal)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(MockData.sampleCards) { card in
                            NavigationLink {
                                CardsDetailView(cardId: card.id)
                                    .toolbar(.hidden, for: .tabBar)
                            } label: {
                                CardsView(
                                    flatName: card.flatName,
                                    location: card.location,
                                    cost: card.cost,
                                    rating: card.rating,
                                    label: card.label,
                                    imageName: card.imageName,
                                    imageURL: card.imageURL
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                NavigationLink {
                    SectionDetailView(
                        sectionTitle: "Available for similar dates",
                        cards: MockData.availableForSimilarDates
                    )
                    .toolbar(.hidden, for: .tabBar)
                } label: {
                    HStack {
                        Text("Available for similar dates")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Theme.textPrimary)
                            .lineLimit(1)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Theme.textPrimary)
                    }
                    .padding(.horizontal)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(MockData.availableForSimilarDates) { card in
                            NavigationLink {
                                CardsDetailView(cardId: card.id)
                                    .toolbar(.hidden, for: .tabBar)
                            } label: {
                                CardsView(
                                    flatName: card.flatName,
                                    location: card.location,
                                    cost: card.cost,
                                    rating: card.rating,
                                    label: card.label,
                                    imageName: card.imageName,
                                    imageURL: card.imageURL
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                NavigationLink {
                    SectionDetailView(
                        sectionTitle: "Stay in Puducherry",
                        cards: MockData.stayInPuducherry
                    )
                    .toolbar(.hidden, for: .tabBar)
                } label: {
                    HStack {
                        Text("Stay in Puducherry")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Theme.textPrimary)
                            .lineLimit(1)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Theme.textPrimary)
                    }
                    .padding(.horizontal)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(MockData.stayInPuducherry) { card in
                            NavigationLink {
                                CardsDetailView(cardId: card.id)
                                    .toolbar(.hidden, for: .tabBar)
                            } label: {
                                CardsView(
                                    flatName: card.flatName,
                                    location: card.location,
                                    cost: card.cost,
                                    rating: card.rating,
                                    label: card.label,
                                    imageName: card.imageName,
                                    imageURL: card.imageURL
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                NavigationLink {
                    SectionDetailView(
                        sectionTitle: "Stay in Paris",
                        cards: MockData.stayInParis
                    )
                    .toolbar(.hidden, for: .tabBar)
                } label: {
                    HStack {
                        Text("Stay in Paris")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Theme.textPrimary)
                            .lineLimit(1)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Theme.textPrimary)
                    }
                    .padding(.horizontal)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(MockData.stayInParis) { card in
                            NavigationLink {
                                CardsDetailView(cardId: card.id)
                                    .toolbar(.hidden, for: .tabBar)
                            } label: {
                                CardsView(
                                    flatName: card.flatName,
                                    location: card.location,
                                    cost: card.cost,
                                    rating: card.rating,
                                    label: card.label,
                                    imageName: card.imageName,
                                    imageURL: card.imageURL
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    var experiencesSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading) {
                NavigationLink {
                    SectionDetailView(
                        sectionTitle: "Airbnb Originals",
                        cards: MockData.airbnbOriginals
                    )
                    .toolbar(.hidden, for: .tabBar)
                } label: {
                    HStack {
                        Text("Airbnb Originals")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                            .lineLimit(1)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                    }
                    .padding(.horizontal)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(MockData.airbnbOriginals) { experience in
                            NavigationLink {
                                CardsDetailView(cardId: experience.id)
                                    .toolbar(.hidden, for: .tabBar)
                            } label: {
                                CardsView(
                                    flatName: experience.flatName,
                                    location: experience.location,
                                    cost: experience.cost,
                                    rating: experience.rating,
                                    label: experience.label,
                                    imageName: experience.imageName,
                                    imageURL: experience.imageURL
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Discover services on Airbnb")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    NavigationLink {
                        SectionDetailView(
                            sectionTitle: "Photography",
                            cards: MockData.photographyExperiences
                        )
                        .toolbar(.hidden, for: .tabBar)
                    } label: {
                        HStack {
                            Text("Photography")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Theme.textPrimary)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(MockData.photographyExperiences) { experience in
                                NavigationLink {
                                    CardsDetailView(cardId: experience.id)
                                        .toolbar(.hidden, for: .tabBar)
                                } label: {
                                    CardsView(
                                        flatName: experience.flatName,
                                        location: experience.location,
                                        cost: experience.cost,
                                        rating: experience.rating,
                                        label: experience.label,
                                        imageName: experience.imageName,
                                        imageURL: experience.imageURL
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            
            VStack(alignment: .leading) {
                NavigationLink {
                    SectionDetailView(
                        sectionTitle: "All experiences in Promenade Beach",
                        cards: MockData.allExperiencesPondicherry
                    )
                    .toolbar(.hidden, for: .tabBar)
                } label: {
                    HStack {
                        Text("All experiences in Promenade Beach")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                            .lineLimit(1)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                    }
                    .padding(.horizontal)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(MockData.allExperiencesPondicherry) { experience in
                            NavigationLink {
                                CardsDetailView(cardId: experience.id)
                                    .toolbar(.hidden, for: .tabBar)
                            } label: {
                                CardsView(
                                    flatName: experience.flatName,
                                    location: experience.location,
                                    cost: experience.cost,
                                    rating: experience.rating,
                                    label: experience.label,
                                    imageName: experience.imageName,
                                    imageURL: experience.imageURL
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    var servicesSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Services in Promenade Beach")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(MockData.servicesInPromenadeBeach) { service in
                            Button {
                            } label: {
                                ServiceCardView(service: service)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Discover services on Airbnb")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Photography")
                        .font(.system(size: 16, weight: .bold))
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(MockData.photographyExperiences) { experience in
                                NavigationLink {
                                    CardsDetailView(cardId: experience.id)
                                        .toolbar(.hidden, for: .tabBar)
                                } label: {
                                    CardsView(
                                        flatName: experience.flatName,
                                        location: experience.location,
                                        cost: experience.cost,
                                        rating: experience.rating,
                                        label: experience.label,
                                        imageName: experience.imageName,
                                        imageURL: experience.imageURL
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

// MARK: - Collapsible Top Bar
private extension ExploreView {
    var topBar: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Explore")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Theme.textPrimary)
                Spacer()
                Button {
                    isSearching = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Theme.textPrimary)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.6)))
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 8)
            Divider()
                .opacity(0.6)
        }
        .background(.ultraThinMaterial)
    }
}

// MARK: - Scroll Offset Preference
private struct ExploreScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    ExploreView()
}
