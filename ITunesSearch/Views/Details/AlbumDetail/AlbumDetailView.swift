//
//  AlbumDetailView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/23.
//

import SwiftUI

struct AlbumDetailView: View {
    let album: Album
    let tracks: [Music]
    
    var body: some View {
        NavigationStack {
            albumCover
            albumHeader
            trackList
            albumDescription
        }
    }
    
    var albumCover: some View {
        AsyncImage(url: album.artworkUrl100) { parse in
            switch parse {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                default:
                    Rectangle()
            }
        }
        .frame(maxWidth: 240)
        .aspectRatio(1, contentMode: .fit)
    }
    
    var albumHeader: some View {
        VStack {
            Text(album.collectionName)
            Text(album.artistName)
            Text("\(album.primaryGenreName)．\(String(getReleaseDate(releaseDate:album.releaseDate).prefix(4)))")
        }
    }
    
    var trackList: some View {
        List(0..<tracks.count, id: \.self) { index in
            HStack {
                Text(String(format: "%2d", index+1))
                Text("\(tracks[index].trackName)")
            }
        }
        .listStyle(.plain)
    }
    
    var albumDescription: some View {
        VStack {
            Text(getReleaseDate(releaseDate:album.releaseDate))
            Text("\(album.trackCount) songs")
            Text(album.copyright)
        }
    }
}

#Preview {
    AlbumDetailView(album: Album.sampleData, tracks: Music.sampleList)
}
