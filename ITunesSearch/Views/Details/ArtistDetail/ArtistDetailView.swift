//
//  ArtistDetailView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/22.
//

import SwiftUI

struct ArtistDetailView: View {
    let artist: Artist
    let tracks: [Music] = Music.sampleList
    let albums: [Album] = Album.sampleList
    
    @State var defaultImageHeight: CGFloat = .zero
    @State var avatar: URL?
    @State var scrollOffset: CGFloat = .zero
    
    var body: some View {
        ScrollView {
            Section {
                artistContent
            } header: {
                avatarSizeHandler
            }
        }
        .coordinateSpace(name: "area")
        .overlay(alignment: .top) {
            artistAvatar
        }
    }
    
    
    var artistContent: some View {
        VStack(alignment: .leading) {
            Text("\(artist.artistName)")
                .font(.title)
                .fontWeight(.bold)
            allSongs
            allAlbums
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    var allSongs: some View {
        Section {
            VStack(spacing: 14) {
                ForEach(tracks[0...min(3, tracks.count - 1)]) { track in
                    MusicCardView(music: track)
                }
            }
        } header: {
            HStack {
                Text("All Songs")
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image(systemName: "chevron.forward")
                }
            }
            .font(.headline)
            .padding(.top, 4)
        }
    }
    
    var allAlbums: some View {
        Section {
            ScrollView(.horizontal) {
                HStack(spacing: 14) {
                    ForEach(albums) { album in
                        AlbumCardView(album: album)
                            .frame(width: 150)
                    }
                }
            }
        } header: {
            HStack {
                Text("Albums")
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image(systemName: "chevron.forward")
                }
            }
            .font(.headline)
            .padding(.top, 10)
        }
    }
    
    var avatarSizeHandler: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: SizePreferenceKey.self, value: geometry.frame(in: .named("area")).minY)
        }
        .scaledToFit()
        .onPreferenceChange(SizePreferenceKey.self) {
            scrollOffset = $0
        }
    }
    
    var artistAvatar: some View {
        GeometryReader { geometry in
            AsyncImage(url: avatar) { parse in
                switch parse {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    default:
                        Rectangle()
                }
            }
            .task {
                avatar = await artist.getArtistURL()
            }
            .scaledToFill()
            .padding(.horizontal, min(0, -scrollOffset))
            .frame(height: geometry.size.height + max(0, scrollOffset))
            .offset(CGSize(width: 0, height: min(0, scrollOffset)))
        }
        .scaledToFit()
    }
    
    private struct SizePreferenceKey: PreferenceKey {
        typealias Value = CGFloat
        
        static var defaultValue: CGFloat = .zero
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}

#Preview {
    
    ArtistDetailView(artist: Artist.sampleData)
    
}
