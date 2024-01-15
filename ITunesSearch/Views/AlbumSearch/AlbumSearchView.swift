//
//  AlbumSearchView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/15.
//

import SwiftUI

struct AlbumSearchView: View {
    
    @State var albums: [Album]
    @State var query = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(spacing: 20), GridItem()]) {
                    ForEach(albums) { album in
                        NavigationLink(destination: Text(album.collectionName)) {
                            AlbumCardView(album: album)
                        }
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Album")
            }
        }
        .searchable(text: $query, prompt: "Search for album")
    }
    
}

#Preview {
    
    AlbumSearchView(albums: Album.sampleList)
    
}
