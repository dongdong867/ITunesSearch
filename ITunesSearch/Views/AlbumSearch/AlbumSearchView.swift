//
//  AlbumSearchView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/15.
//

import SwiftUI

struct AlbumSearchView: View {
    
    @StateObject var albumSearch: AlbumSearch
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(spacing: 20), GridItem()]) {
                    ForEach(albumSearch.result) { album in
                        NavigationLink(destination: Text(album.collectionName)) {
                            AlbumCardView(album: album)
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Album")
            }
        }
        .searchable(text: $albumSearch.query, prompt: "Search for album")
    }
    
}

#Preview {
    
    AlbumSearchView(albumSearch: AlbumSearch())
    
}
