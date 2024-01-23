//
//  AlbumDetailView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/23.
//

import SwiftUI

struct AlbumDetailView: View {
    
    let album: Album
    @ObservedObject var albumDetail: AlbumDetail
    
    init(album: Album) {
        self.album = album
        self.albumDetail = AlbumDetail(albumId: album.artistId)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                albumCover
                albumHeader
                trackList
                albumDescription
            }
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
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, y: 5)
    }
    
    var albumHeader: some View {
        VStack {
            Text(album.collectionName)
                .font(.headline)
            
            NavigationLink {
                ArtistDetailView(artist: Artist(
                    artistLinkUrl: album.artistViewUrl,
                    artistName: album.artistName,
                    artistId: album.artistId
                ))
                .navigationBarTitleDisplayMode(.inline)
            } label: {
                Text(album.artistName)
                    .foregroundStyle(.red)
                    .fontWeight(.medium)
            }

            Text("\(album.primaryGenreName)．\(String(getReleaseDate(releaseDate:album.releaseDate).prefix(4)))")
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
                .padding(.vertical, 1)
        }
        .padding()
    }
    
    var trackList: some View {
        LazyVStack(alignment: .leading) {
            Divider()
            
            ForEach(0..<albumDetail.tracks.count, id: \.self) { index in
                NavigationLink {
                    MusicDetailView(music: albumDetail.tracks[index])
                } label: {
                    HStack {
                        Text(String(format: "%2d", index+1))
                            .foregroundStyle(.gray)
                        
                        Text("\(albumDetail.tracks[index].trackName)")
                            .tint(.primary)
                    }
                    .lineLimit(1)
                    .padding(.vertical, 4)
                }
                
                
                
                
                Divider()
            }
            .listStyle(.plain)
        }
        .padding()
    }
    
    var albumDescription: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(getReleaseDate(releaseDate:album.releaseDate))
                Text("\(album.trackCount) songs")
                Text(album.copyright)
            }
            .font(.footnote)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AlbumDetailView(album: Album.sampleData)
}
