//
//  CardsDetailView.swift
//  syGroupTask
//
//  Created by Amritesh Kumar on 03/09/25.
//

import SwiftUI

struct CardsDetailView: View {
    let cardId: UUID
    var matchedNamespace: Namespace.ID? = nil
    @State private var propertyDetail: PropertyDetail
    @Environment(\.dismiss) private var dismiss
    @GestureState private var dragOffset: CGFloat = 0
    
    init(cardId: UUID) {
        self.cardId = cardId
        self._propertyDetail = State(initialValue: MockData.getPropertyDetailOrDefault(for: cardId))
    }

    init(cardId: UUID, matchedNamespace: Namespace.ID?) {
        self.cardId = cardId
        self.matchedNamespace = matchedNamespace
        self._propertyDetail = State(initialValue: MockData.getPropertyDetailOrDefault(for: cardId))
    }

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Theme.textPrimary)
                }
                .padding(.leading)
                
                Spacer()
            }
            .padding(.top, 8)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Parallax Header Carousel
                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .global).minY
                        let height: CGFloat = 280
                        TabView {
                            ForEach(propertyDetail.images, id: \.self) { imageURL in
                                AsyncImage(url: URL(string: imageURL)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .transition(.opacity.combined(with: .scale(scale: 0.98)))
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                }
                                .frame(width: proxy.size.width, height: height + (minY > 0 ? minY : 0))
                                .clipped()
                                .offset(y: (minY > 0) ? -minY : 0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .fill(Color.clear)
                                        .matchedGeometryEffect(id: "image-\(cardId)", in: matchedNamespace ?? Namespace().wrappedValue)
                                )
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(height: height)
                    }
                    .frame(height: 280)

                    // Title + Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text(propertyDetail.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Theme.textPrimary)

                        Text("\(propertyDetail.subtitle) in \(propertyDetail.location)\n\(propertyDetail.maxGuests) guests · \(propertyDetail.bedrooms) bedrooms · \(propertyDetail.bedrooms) beds · \(propertyDetail.bathrooms) bathrooms")
                            .font(.subheadline)
                            .foregroundColor(Theme.textSecondary)
                    }
                    .padding(.horizontal)

                    Divider()

                    // Ratings + Guest Favourite + Reviews
                    HStack {
                        VStack {
                            Text(String(format: "%.2f", propertyDetail.rating))
                                .fontWeight(.bold)
                                .foregroundColor(Theme.textPrimary)
                            HStack(spacing: 2) {
                                ForEach(0..<5) { index in
                                    Image(systemName: "star.fill")
                                        .font(.caption)
                                        .foregroundColor(index < Int(propertyDetail.rating) ? Theme.star : Theme.textSecondary)
                                }
                            }
                        }
                        Spacer()
                        if propertyDetail.isGuestFavourite {
                            VStack {
                                Text("Guest")
                                    .fontWeight(.bold)
                                    .foregroundColor(Theme.textPrimary)
                                Text("favourite")
                                    .font(.caption)
                                    .foregroundColor(Theme.textSecondary)
                            }
                            Spacer()
                        }
                        VStack {
                            Text("\(propertyDetail.reviewCount)")
                                .fontWeight(.bold)
                                .foregroundColor(Theme.textPrimary)
                            Text("Reviews")
                                .font(.caption)
                                .foregroundColor(Theme.textSecondary)
                        }
                    }
                    .padding(.horizontal)

                    Divider()

                    // Host Info
                    HStack {
                        AsyncImage(url: URL(string: propertyDetail.host.profileImage)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Circle()
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .foregroundColor(Theme.textSecondary)
                                )
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(lineWidth: 1))

                        VStack(alignment: .leading) {
                            HStack {
                                Text("Hosted by \(propertyDetail.host.name)")
                                    .fontWeight(.bold)
                                    .foregroundColor(Theme.textPrimary)
                                if propertyDetail.host.isSuperhost {
                                    Text("★ Superhost")
                                        .font(.caption)
                                        .foregroundColor(Theme.star)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 2)
                                        .background(Theme.star.opacity(0.1))
                                        .cornerRadius(4)
                                }
                            }
                            Text("\(propertyDetail.host.hostingSince) years hosting")
                                .font(.subheadline)
                                .foregroundColor(Theme.textSecondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)

                    Divider()

                    // Amenities Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("What this place offers")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Theme.textPrimary)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(propertyDetail.amenities, id: \.self) { amenity in
                                HStack {
                                    Image(systemName: getAmenityIcon(amenity))
                                        .foregroundColor(Theme.textSecondary)
                                        .frame(width: 20)
                                    Text(amenity)
                                        .font(.subheadline)
                                        .foregroundColor(Theme.textPrimary)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("About this place")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Theme.textPrimary)
                        
                        Text(propertyDetail.description)
                            .font(.body)
                            .foregroundColor(Theme.textSecondary)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal)

                    Divider()

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Meet your host")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Theme.textPrimary)
                        
                        VStack(spacing: 8) {
                            HStack {
                                Text("Response rate:")
                                    .foregroundColor(Theme.textSecondary)
                                Spacer()
                                Text(propertyDetail.host.responseRate)
                                    .fontWeight(.medium)
                                    .foregroundColor(Theme.textPrimary)
                            }
                            
                            HStack {
                                Text("Response time:")
                                    .foregroundColor(Theme.textSecondary)
                                Spacer()
                                Text(propertyDetail.host.responseTime)
                                    .fontWeight(.medium)
                                    .foregroundColor(Theme.textPrimary)
                            }
                        }
                        .padding()
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    Spacer()
                        .frame(height: 100)
                }
                .padding(.vertical, 8)
            }
            .tabBarHidden(true)
            .scaleEffect(1 - min(max(dragOffset, 0 as CGFloat), 120 as CGFloat) / 1500 as CGFloat)
            .opacity(1 - min(max(dragOffset, 0 as CGFloat), 120 as CGFloat) / 300 as CGFloat)
            .gesture(
                DragGesture(minimumDistance: 8, coordinateSpace: .local)
                    .updating($dragOffset) { value, state, _ in
                        if value.translation.height > 0 { state = value.translation.height }
                    }
                    .onEnded { value in
                        if value.translation.height > 120 {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) { dismiss() }
                            Haptics.selectionChanged()
                        }
                    }
            )

            VStack {
                Divider()
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(propertyDetail.currency)\(propertyDetail.pricePerNight) night")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Theme.textPrimary)
                        HStack {
                            Text("⭐️ \(String(format: "%.2f", propertyDetail.rating))")
                                .font(.caption)
                                .foregroundColor(Theme.textSecondary)
                            Text("·")
                                .foregroundColor(Theme.textSecondary)
                            Text("\(propertyDetail.checkIn) - \(propertyDetail.checkOut)")
                                .font(.caption)
                                .foregroundColor(Theme.textSecondary)
                        }
                    }
                    Spacer()
                    Button(action: {
                        print("Check availability tapped for \(propertyDetail.title)")
                    }) {
                        Text("Check availability")
                            .fontWeight(.bold)
                            .foregroundColor(Theme.textLight)
                            .padding()
                            .frame(width: 180)
                            .background(Theme.primaryColor)
                            .cornerRadius(12)
                    }
                }
                .padding()
                .background(Theme.background)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden()
    }
    
    private func getAmenityIcon(_ amenity: String) -> String {
        switch amenity.lowercased() {
        case "wifi": return "wifi"
        case "kitchen": return "fork.knife"
        case "air conditioning": return "snow"
        case "pool": return "figure.pool.swim"
        case "free parking", "parking": return "car.fill"
        case "tv": return "tv.fill"
        case "washer": return "washinmachine.fill"
        case "iron": return "iron.fill"
        case "beach access": return "beach.umbrella.fill"
        case "hot tub": return "bathtub.fill"
        case "bbq grill": return "flame.fill"
        case "mountain view": return "mountain.2.fill"
        case "fireplace": return "flame.fill"
        case "heating": return "thermometer.sun.fill"
        case "garden": return "leaf.fill"
        case "hiking trails": return "figure.hiking"
        case "shared kitchen": return "fork.knife"
        case "meditation space": return "leaf.fill"
        case "bicycle": return "bicycle"
        case "breakfast": return "cup.and.saucer.fill"
        case "terrace": return "building.2.fill"
        default: return "checkmark.circle.fill"
        }
    }
}

#Preview {
    NavigationView {
        CardsDetailView(cardId: UUID())
    }
}
