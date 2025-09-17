//
//  SearchResultCard.swift
//  syGroupTask
//
//  Created by Amritesh Kumar on 04/09/25.
//

import SwiftUI

struct SearchResultCard: View {
    let card: CardModel
    var namespace: Namespace.ID? = nil
    @State private var isLiked: Bool = false
    @State private var imageRevealed: Bool = false
    @State private var likeScale: CGFloat = 1.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .topTrailing) {
                ConfettiView(trigger: .constant(isLiked))
                ZStack(alignment: .topLeading) {
                    if let imageURL = card.imageURL {
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .blur(radius: imageRevealed ? 0 : 8)
                                .animation(.easeOut(duration: 0.35), value: imageRevealed)
                        } placeholder: {
                            ShimmerSkeleton(cornerRadius: 12, width: nil, height: 120)
                        }
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.clear)
                                .matchedGeometryEffect(id: "image-\(card.id)", in: namespace ?? Namespace().wrappedValue, isSource: true)
                        )
                        .onAppear { imageRevealed = true }
                    } else {
                        Image(card.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.clear)
                                    .matchedGeometryEffect(id: "image-\(card.id)", in: namespace ?? Namespace().wrappedValue, isSource: true)
                            )
                    }
                    
                    Text(card.label)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Theme.textPrimary)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(Theme.textLight.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(6)
                }
                
                Button {
                    isLiked.toggle()
                    Haptics.light()
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) { likeScale = 1.15 }
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.7).delay(0.08)) { likeScale = 1.0 }
                } label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(isLiked ? Theme.primaryColor : Theme.textLight)
                        .frame(width: 24, height: 24)
                        .background(Theme.textPrimary.opacity(0.3))
                        .clipShape(Circle())
                        .scaleEffect(likeScale)
                }
                .padding(6)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(card.flatName)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Theme.textPrimary)
                    .lineLimit(2)
                
                Text(card.location)
                    .font(.system(size: 11))
                    .foregroundColor(Theme.textSecondary)
                    .lineLimit(1)
                
                Text(card.cost)
                    .font(.system(size: 11))
                    .foregroundColor(Theme.textSecondary)
                    .lineLimit(1)
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(Theme.star)
                    
                    Text(String(format: "%.1f", card.rating))
                        .font(.system(size: 11))
                        .foregroundColor(Theme.textPrimary)
                }
            }
            .padding(.horizontal, 4)
        }
    }
}
