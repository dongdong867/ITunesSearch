//
//  MusicPlayer.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/19.
//

import SwiftUI
import AVFoundation

class MusicPlayer: ObservableObject {
    
    @Published var audioPlayer: AVPlayer
    
    init(audioURL: URL) {
        let playerItem = AVPlayerItem(url: audioURL)
        audioPlayer = AVPlayer(playerItem: playerItem)
    }
    
    func getDuration() async -> String {
        guard let currentItem = audioPlayer.currentItem else { return "--:--" }
        var durationSeconds: TimeInterval
        
        do {
            durationSeconds = try await currentItem.asset.load(.duration).seconds.rounded()
        } catch {
            return "--:--"
        }
        
        return formatTime(durationSeconds)
    }
    
    func getCurrentTime() -> String {
        guard let currentItem = audioPlayer.currentItem else { return "--:--"}
        return formatTime(currentItem.currentTime().seconds.rounded())
    }
    
    
    private func formatTime(_ time: TimeInterval) -> String {
        var hour: Int { Int(time / 3600) }
        var minute: Int { Int(time.truncatingRemainder(dividingBy: 3600) / 60) }
        var second: Int { Int(time.truncatingRemainder(dividingBy: 60)) }
        
        return hour > 0
            ? String(format: "%d:%02d:%02d", hour, minute, second)
            : String(format: "%02d:%02d", minute, second)
    }
}
