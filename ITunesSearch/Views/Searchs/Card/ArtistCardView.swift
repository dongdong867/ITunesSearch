//
//  ArtistCardView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/16.
//

import SwiftUI

struct ArtistCardView: View {
    var artist: Artist
    @State var avatarURL: URL? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            coverImage
            cardInfo
        }
        .frame(alignment: .leading)
    }
    
    var coverImage: some View {
        AsyncImage(url: avatarURL) { phase in
            switch phase {
                case .empty:
                    Color.gray.opacity(0.8)
                        .aspectRatio(1, contentMode: .fill)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                default:
                    imageError
            }
        }
        .frame(width: .infinity, height: .infinity)
        .background(.gray.opacity(0.3))
        .clipShape(.circle)
        .task {
            avatarURL = await artist.getArtistURL()
        }
    }
    
    var imageError: some View {
        Image(systemName: "exclamationmark.triangle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 25)
            .foregroundStyle(.red)
    }
    
    var cardInfo: some View {
            Text(artist.artistName)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ArtistCardView(artist: Artist.sampleData)
}
