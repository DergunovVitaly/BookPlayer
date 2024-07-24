//
//  AudioPlayerService.swift
//  BookPlayer
//
//  Created by Vitaliy on 24.07.2024.
//

import Foundation
import ComposableArchitecture

struct AudioPlayerService {
    var setup: (String) -> Effect<Never, Never>
    var play: () -> Effect<Never, Never>
    var pause: () -> Effect<Never, Never>
    var stop: () -> Effect<Never, Never>
    var seek: (TimeInterval) -> Effect<Never, Never>
    var setRate: (Float) -> Effect<Never, Never>
}

extension AudioPlayerService {
    static let live = AudioPlayerService(
        setup: { fileName in
            AudioPlayer.shared.setupAudioPlayer(with: fileName)
        },
        play: {
            AudioPlayer.shared.play()
        },
        pause: {
            AudioPlayer.shared.pause()
        },
        stop: {
            AudioPlayer.shared.stop()
        },
        seek: { time in
            AudioPlayer.shared.seek(to: time)
        },
        setRate: { rate in
            AudioPlayer.shared.setRate(to: rate)
        }
    )
}
