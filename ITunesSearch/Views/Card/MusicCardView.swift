//
//  MusicCardView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/12.
//

import SwiftUI

struct MusicCardView: View {
    let music: Music
    
    var body: some View {
        HStack(spacing: 20) {
            coverImage
            cardInfo
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    var coverImage: some View {
        AsyncImage(url: music.artworkUrl100) { phase in
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
        .frame(width: 60, height: 60)
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
            Text(music.trackName)
                .font(.headline)

            Text("\(music.collectionName) - \(music.artistName)")
                .clipped()
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
        }
    }
}


#Preview {
    
    return MusicCardView(music: Music.sampleData)

}
