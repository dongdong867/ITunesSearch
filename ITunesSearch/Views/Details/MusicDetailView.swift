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
    
    init(music: Music) {
        self.music = music
        musicPlayer = MusicPlayer(audioURL: music.previewUrl)
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
        .padding(.horizontal, 40)
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
            ProgressSlider(value: $musicPlayer.playedPercentage, onEditingChanged: { newValue in
                Task {
                    await musicPlayer.seek(to: newValue)
                }
            })
                .frame(maxWidth: .infinity, maxHeight: 10)
            HStack {
                Text(formatTime(musicPlayer.currentTime.seconds))
                Spacer()
                Text(formatTime(musicPlayer.duration.seconds))
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
            playButton
            Spacer()
            
            Image(systemName: "forward.fill")
                .font(.largeTitle)
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .padding(.horizontal, 40)
    }
    
    var playButton: some View {
        switch musicPlayer.status {
            case .playing:
                Image(systemName: "pause.fill")
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        musicPlayer.pause()
                    }
                
            default:
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        if musicPlayer.status == .pause { musicPlayer.play() }
                    }
        }
    }
    
    var volumeControl: some View {
        HStack(spacing: 16) {
            Image(systemName: "volume.fill")
            
            ProgressSlider(value: $musicPlayer.volume)
                .onChange(of: musicPlayer.volume) { _, newValue in
                    musicPlayer.setVolume(to: newValue)
                }
                .frame(maxWidth: .infinity, maxHeight: 10)
            
            Image(systemName: "volume.3.fill")
        }
        .foregroundStyle(.gray)
    }
    
    
    func formatTime(_ time: TimeInterval) -> String {
        var hour: Int { Int(time / 3600) }
        var minute: Int { Int(time.truncatingRemainder(dividingBy: 3600) / 60) }
        var second: Int { Int(time.truncatingRemainder(dividingBy: 60)) }
        
        return hour > 0
        ? String(format: "%d:%02d:%02d", hour, minute, second)
        : String(format: "%02d:%02d", minute, second)
    }
}

#Preview {
    
    MusicDetailView(music: Music.sampleData)
    
}
