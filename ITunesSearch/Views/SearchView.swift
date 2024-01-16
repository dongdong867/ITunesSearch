//
//  SearchView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/12.
//

import SwiftUI

struct SearchView: View {
    
    var body: some View {
        TabView {
            MusicSearchView(musicSearch: MusicSearch())
                .tabItem {
                    Image(systemName: "music.note")
                    Text("Music")
                }
            
            ArtistSearchView(artistSearch: ArtistSearch())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Artist")
                }
            
            AlbumSearchView(albumSearch: AlbumSearch())
                .tabItem {
                    Image(systemName: "tray.full.fill")
                    Text("Album")
                }
        }
    }
}

#Preview {
    SearchView()
}
