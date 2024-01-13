//
//  MusicSearchListView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/13.
//

import SwiftUI

struct MusicSearchListView: View {
    @State var musicList: [Music]
    
    var body: some View {
        NavigationStack {
            List(musicList) { music in
                MusicCardView(music: music)
            }
        }
        
    }
}

#Preview {
    MusicSearchListView(musicList: Music.sampleList)
}
