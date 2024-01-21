//
//  MusicPlayer.swift
//  ITunesSearch
//
//  Created by Dong on 2024/1/19.
//

import SwiftUI
import Combine
import AVFoundation

class MusicPlayer: ObservableObject {
    
    @Published var status: PlayerStatus = .pause
    @Published var volume = AVAudioSession.sharedInstance().outputVolume
    @Published var playedPercentage: Double = 0.0
    @Published var currentTime = CMTime(seconds: 0.0, preferredTimescale: .max)
    @Published var duration = CMTime(seconds: 0.0, preferredTimescale: .max)
    
    private var audioPlayer: AVPlayer
    private var timeObserver: Any?
    
    
    init(audioURL: URL) {
        let playerItem = AVPlayerItem(url: audioURL)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer.volume = volume
        Task {
            var duration: CMTime
            do {
                guard let currentItem = audioPlayer.currentItem else { throw MusicPlayerError.currentItemNotFound }
                duration = try await currentItem.asset.load(.duration)
            } catch {
                duration = CMTime(seconds: 0.0, preferredTimescale: .zero)
            }
            
            self.duration = duration
        }

    }
    
    deinit {
        guard let timeObserver = timeObserver else {
            return
        }
        audioPlayer.removeTimeObserver(timeObserver)
    }
    
    func play() -> Void {
        audioPlayer.play()
        status = .playing
        addTimeObserver()
    }
    
    func pause() -> Void {
        audioPlayer.pause()
        removeTimeObserver()
    }
    
    func seek(to percentage: Double) async -> Void {
        let time: CMTime = CMTime(seconds: percentage * duration.seconds.rounded(), preferredTimescale: .max)
        
        await audioPlayer.seek(to: time)
        currentTime = time
    }
    
    func setVolume(to volume: Float) -> Void {
        audioPlayer.volume = volume
    }
    
    private func addTimeObserver() -> Void {
        timeObserver = audioPlayer.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 100),
            queue: .main
        ) { [weak self] time in
            self?.currentTime = time
            self?.playedPercentage = time.seconds / (self?.duration.seconds ?? 1)
            
            if time >= self?.duration ?? CMTime(seconds: 0, preferredTimescale: .max) {
                self?.pause()
            }
        }
    }
    
    private func removeTimeObserver() -> Void {
        guard let timeObserver = timeObserver else {
            return
        }
        audioPlayer.removeTimeObserver(timeObserver)
        self.status = .pause
    }
    
    enum PlayerStatus: String {
        case playing = "playing"
        case pause = "pause"
        case loading = "loading"
    }
}
