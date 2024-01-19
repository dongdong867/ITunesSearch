//
//  MusicPlayer.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/19.
//

import SwiftUI
import AVFoundation

class MusicPlayer: ObservableObject {
    
    @Published var status: PlayerStatus = .pause
    @Published var currentTime: String = "00:00"
    
    private var audioPlayer: AVPlayer
    private var timeObserver: Any?
    
    init(audioURL: URL) {
        let playerItem = AVPlayerItem(url: audioURL)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer.volume = 0.1
    }
    
    func play() -> Void {
        audioPlayer.play()
        addTimeObserver()
        status = .playing
    }
    
    func pause() -> Void {
        audioPlayer.pause()
        removeTimeObserver()
        status = .pause
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
    
    private func addTimeObserver() -> Void {
        timeObserver = audioPlayer.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 1000),
            queue: .main
        ) { [weak self] time in
            self?.currentTime = self?.formatTime(time.seconds.rounded()) ?? "--:--"
        }
    }
    
    private func removeTimeObserver() -> Void {
        guard let timeObserver = timeObserver else {
            return
        }
        audioPlayer.removeTimeObserver(timeObserver)
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        var hour: Int { Int(time / 3600) }
        var minute: Int { Int(time.truncatingRemainder(dividingBy: 3600) / 60) }
        var second: Int { Int(time.truncatingRemainder(dividingBy: 60)) }
        
        return hour > 0
            ? String(format: "%d:%02d:%02d", hour, minute, second)
            : String(format: "%02d:%02d", minute, second)
    }
    
    enum PlayerStatus {
        case playing
        case pause
    }
}
