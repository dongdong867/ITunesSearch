//
//  MusicSearchView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/13.
//

import SwiftUI

struct MusicSearchView: View {
    @State var musicList: [Music]
    @State var query: String = ""
    
    var body: some View {
        NavigationStack {
            List(musicList) { music in
                NavigationLink(destination: Text(music.trackName)) {
                    MusicCardView(music: music)
                }
            }
            .navigationTitle("Search")
            .scrollContentBackground(.hidden)
        }
        .searchable(text: $query)
    }
    
}

#Preview {
    MusicSearchView(musicList: Music.sampleList)
}
