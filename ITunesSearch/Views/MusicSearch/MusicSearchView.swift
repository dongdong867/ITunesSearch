//
//  MusicSearchView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/13.
//

import SwiftUI

struct MusicSearchView: View {
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
    MusicSearchView(musicList: Music.sampleList)
}
