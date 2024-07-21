//
//  AudioPlayer.swift
//  BookPlayer
//
//  Created by Vitaliy on 18.07.2024.
//

import Foundation
import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var isPlaying = false
    @Published var currentTime: TimeInterval = 0.0
    @Published var playbackRate: Float = 1.0
    @Published var errorMessage: String?
    
    private var player: AVAudioPlayer?
    private var timer: Timer?
    private var isDragging = false
    
    func setupAudioPlayer(with fileName: String, fileExtension: String = "mp3") async {
        guard let audioURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            updateErrorMessage(with: .fileNotFound)
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: audioURL)
            player?.delegate = self
            player?.enableRate = true
            player?.prepareToPlay()
            player?.rate = playbackRate
            resetPlayerState()
            startTimer()
        } catch {
            updateErrorMessage(with: .initializationFailed(error))
        }
    }
    
    func playPauseAudio() async {
        guard let player = player else {
            updateErrorMessage(with: .playerNotInitialized)
            return
        }
        
        DispatchQueue.main.async {
            if player.isPlaying {
                self.pausePlayer()
            } else {
                self.playPlayer()
            }
        }
    }
    
    func play() async {
        guard player != nil else {
            updateErrorMessage(with: .playerNotInitialized)
            return
        }
        playPlayer()
    }
    
    func stopAudio() async {
        guard player != nil else {
            updateErrorMessage(with: .playerNotInitialized)
            return
        }
        stopPlayer()
    }
    
    func rewindAudio() async {
        adjustCurrentTime(by: -10)
    }
    
    func forwardAudio() async {
        adjustCurrentTime(by: 10)
    }
    
    func seekAudio(to time: TimeInterval) async {
        guard let player = player else {
            updateErrorMessage(with: .playerNotInitialized)
            return
        }
        
        DispatchQueue.main.async {
            player.currentTime = time
            self.currentTime = player.currentTime
            if self.isPlaying {
                player.play()
                self.startTimer()
            }
        }
    }
    
    func setPlaybackRate(to rate: Float) async {
        DispatchQueue.main.async {
            self.playbackRate = rate
        }
        guard let player = player else {
            updateErrorMessage(with: .playerNotInitialized)
            return
        }
        player.rate = self.playbackRate
    }
    
    func playerDuration() -> Double {
        return player?.duration ?? 0.0
    }
    
    func startDragging() {
        DispatchQueue.main.async {
            self.isDragging = true
        }
        stopTimer()
    }
    
    func stopDragging() {
        DispatchQueue.main.async {
            self.isDragging = false
        }
        if isPlaying {
            startTimer()
        }
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.player, !self.isDragging else { return }
            DispatchQueue.main.async {
                self.currentTime = player.currentTime
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func playPlayer() {
        guard let player = player else { return }
        DispatchQueue.main.async {
            player.play()
            self.startTimer()
            self.isPlaying = true
        }
    }
    
    private func pausePlayer() {
        guard let player = player else { return }
        DispatchQueue.main.async {
            player.pause()
            self.stopTimer()
            self.isPlaying = false
        }
    }
    
    private func stopPlayer() {
        guard let player = player else { return }
        DispatchQueue.main.async {
            player.stop()
            self.isPlaying = false
            self.currentTime = 0.0
            self.stopTimer()
        }
    }
    
    private func adjustCurrentTime(by seconds: TimeInterval) {
        guard let player = player else {
            updateErrorMessage(with: .playerNotInitialized)
            return
        }
        DispatchQueue.main.async {
            player.currentTime += seconds
            self.currentTime = player.currentTime
        }
    }
    
    private func resetPlayerState() {
        DispatchQueue.main.async {
            self.currentTime = 0.0
            self.errorMessage = nil
        }
    }
    
    private func updateErrorMessage(with error: AudioPlayerError) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            self.isPlaying = false
            self.currentTime = 0.0
            self.stopTimer()
        }
    }
}
