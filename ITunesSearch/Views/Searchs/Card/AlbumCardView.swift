//
//  AlbumCardView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/15.
//

import SwiftUI

struct AlbumCardView: View {
    let album: Album
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            coverImage
            cardInfo
        }
        .frame(alignment: .leading)
    }
    
    var coverImage: some View {
        AsyncImage(url: album.artworkUrl100) { phase in
            switch phase {
                case .empty:
                    Color.gray.opacity(0.8)
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
        .clipShape(.rect(cornerRadius: 8))
        .scaledToFit()
    }
    
    var imageError: some View {
        Image(systemName: "exclamationmark.triangle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 25)
            .foregroundStyle(.red)
    }
    
    var cardInfo: some View {
        VStack(alignment: .leading) {
            Text(album.collectionName)
                .font(.subheadline)
                .fontWeight(.bold)
                .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)


            Text("\(album.artistName) - \(String(getReleaseDate(releaseDate:album.releaseDate).prefix(4)))")
                .clipped()
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    AlbumCardView(album: Album.sampleData)
}
