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
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: 240)
            
            Text(album.collectionName)
            Text(album.artistName)
            Text("\(album.primaryGenreName)．\(String(getReleaseDate(releaseDate:album.releaseDate).prefix(4)))")
            
            List(0..<tracks.count, id: \.self) { index in
                HStack {
                    Text(String(format: "%2d", index+1))
                    Text("\(tracks[index].trackName)")
                }
            }
            .listStyle(.plain)
            
            Text(getReleaseDate(releaseDate:album.releaseDate))
            Text("\(album.trackCount) songs")
            Text(album.copyright)
        }
    }
}

#Preview {
    AlbumDetailView(album: Album.sampleData, tracks: Music.sampleList)
}
