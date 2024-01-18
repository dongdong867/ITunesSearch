//
//  MusicDetailView.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/17.
//

import SwiftUI

struct MusicDetailView: View {
    
    let music: Music
    @ObservedObject var musicPlayer: MusicPlayer
    @State var duration: String = "--:--"
    @State var value: Double = 0.6
    @State var sound: Double = 0.8
    
    init(music: Music) {
        self.music = music
        self.musicPlayer = MusicPlayer(audioURL: music.previewUrl)
    }
    
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
        .shadow(radius: 16, y: 5)
    }
    
    var nameInfo: some View {
        VStack(alignment: .leading) {
            Text(music.trackName)
                .font(.title3)
                .fontWeight(.bold)
            Text(music.artistName)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.red)
        }
        .padding(.vertical)
    }
    
    var timeProgress: some View {
        VStack {
            ProgressSlider(value: $value)
                .frame(maxWidth: .infinity, maxHeight: 10)
            HStack {
                Text(musicPlayer.getCurrentTime())
                Spacer()
                Text(duration)
                    .task {
                        duration = await musicPlayer.getDuration()
                    }
            }
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundStyle(.gray.opacity(0.6))
            .padding(.vertical, 4)
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
        HStack(spacing: 16) {
            Image(systemName: "volume.fill")
            
            ProgressSlider(value: $sound)
                .frame(maxWidth: .infinity, maxHeight: 10)
            
            Image(systemName: "volume.3.fill")
        }
        .foregroundStyle(.gray)
    }
}

#Preview {
    
    MusicDetailView(music: Music.sampleData)
    
}
