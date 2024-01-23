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
                    NavigationLink(destination: MusicDetailView(music: music)) {
                        MusicCardView(music: music)
                            .navigationBarTitleDisplayMode(.inline)
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
