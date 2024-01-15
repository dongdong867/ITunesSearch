//
//  MusicSearchView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/13.
//

import SwiftUI

struct MusicSearchView: View {
    @ObservedObject var musicSearch: MusicSearch
    
    var body: some View {
        NavigationStack {
            if(musicSearch.result.isEmpty && musicSearch.state == .good) {
                Text("No results.")
            } else {
                List(musicSearch.result) { music in
                    NavigationLink(destination: Text(music.trackName)) {
                        MusicCardView(music: music)
                    }
                }
                .navigationTitle("Music")
                .scrollContentBackground(.hidden)
            }
            
        }
        .searchable(text: $musicSearch.query, prompt: "Search for music")
    }
    
}

#Preview {
    MusicSearchView(musicSearch: MusicSearch())
}
