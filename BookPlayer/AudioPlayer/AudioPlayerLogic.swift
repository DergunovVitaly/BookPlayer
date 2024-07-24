//
//  AudioPlayerLogic.swift
//  BookPlayer
//
//  Created by Vitaliy on 23.07.2024.
//

import Foundation
import AVFoundation
import ComposableArchitecture

class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    static let shared = AudioPlayer()
    private var player: AVAudioPlayer?
    
    func setupAudioPlayer(with fileName: String) -> Effect<Never, Never> {
        print("Setting up audio player with file: \(fileName)")
        guard let audioURL = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("Audio file not found")
            return .none
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: audioURL)
            player?.delegate = self
            player?.prepareToPlay()
            print("Audio player prepared and ready to play")
            return .fireAndForget { [weak self] in
                self?.player?.play()
                print("Audio player started playing")
            }
        } catch {
            print("Failed to initialize audio player: \(error)")
            return .none
        }
    }
    
    func play() -> Effect<Never, Never> {
        return .fireAndForget { [weak self] in
            self?.player?.play()
            print("Audio player resumed playing")
        }
    }
    
    func pause() -> Effect<Never, Never> {
        return .fireAndForget { [weak self] in
            self?.player?.pause()
            print("Audio player paused")
        }
    }
    
    func stop() -> Effect<Never, Never> {
        return .fireAndForget { [weak self] in
            self?.player?.stop()
            self?.player = nil
            print("Audio player stopped")
        }
    }
    
    func seek(to time: TimeInterval) -> Effect<Never, Never> {
        return .fireAndForget { [weak self] in
            self?.player?.currentTime = time
            print("Audio player seeked to \(time) seconds")
        }
    }
    
    func setRate(to rate: Float) -> Effect<Never, Never> {
        return .fireAndForget { [weak self] in
            self?.player?.rate = rate
            print("Audio player rate set to \(rate)")
        }
    }
    
    // MARK: - AVAudioPlayerDelegate
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Audio player finished playing")
        // Handle the end of audio playback
    }
}
