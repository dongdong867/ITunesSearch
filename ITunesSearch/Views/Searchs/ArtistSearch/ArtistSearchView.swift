//
//  ArtistSearchView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/16.
//

import SwiftUI

struct ArtistSearchView: View {
    
    @ObservedObject var artistSearch: ArtistSearch
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(spacing: 20), GridItem()]) {
                    ForEach(artistSearch.result) { artist in
                        NavigationLink(destination: Text(artist.artistName)) {
                            ArtistCardView(artist: artist)
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Artist")
            }
        }
        .searchable(text: $artistSearch.query, prompt: "Search for artist")
    }
}

#Preview {
    
    ArtistSearchView(artistSearch: ArtistSearch())
    
}
