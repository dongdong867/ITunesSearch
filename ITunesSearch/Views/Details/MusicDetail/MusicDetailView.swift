//
//  MusicDetailView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/17.
//

import SwiftUI

struct MusicDetailView: View {
    
    let music: Music
    @State var value: Double = 0.6
    @State var sound: Double = 0.8
    
    var body: some View {
        VStack(alignment: .leading) {
            albumCover
            nameInfo
            timeProgress
            
            Spacer()
            
            playStatus
            
            Spacer()
            
            volumeControl
            
            Spacer()
        }
        .padding(40)
    }
    
    var albumCover: some View {
        AsyncImage(url: music.artworkUrl100) { parse in
            switch parse {
                case .empty:
                    Color.gray.opacity(0.3)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                default:
                    Image(systemName: "music.note.list")
            }
        }
        .clipShape(.rect(cornerRadius: 8))
    }
    
    var nameInfo: some View {
        VStack(alignment: .leading) {
            Text(music.trackName)
            Text(music.artistName)
        }
        .padding()
    }
    
    var timeProgress: some View {
        VStack {
            ProgressSlider(value: $value)
                .frame(maxWidth: .infinity, maxHeight: 10)
            HStack {
                Text("2:26")
                Spacer()
                Text("3:39")
            }
        }
    }
    
    var playStatus: some View {
        HStack {
            Image(systemName: "backward.fill")
                .font(.largeTitle)
            
            Spacer()
            
            Image(systemName: "play.fill")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Image(systemName: "forward.fill")
                .font(.largeTitle)
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .padding(.horizontal, 40)
    }
    
    var volumeControl: some View {
        HStack {
            Image(systemName: "volume.1.fill")
            ProgressSlider(value: $sound)
                .frame(maxWidth: .infinity, maxHeight: 10)
            Image(systemName: "volume.3.fill")
        }
    }
}

#Preview {
    
    MusicDetailView(music: Music.sampleData)
    
}
