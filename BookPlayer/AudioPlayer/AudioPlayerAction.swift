//
//  AudioPlayerAction.swift
//  BookPlayer
//
//  Created by Vitaliy on 23.07.2024.
//

import Foundation

enum AudioPlayerAction: Equatable {
    case setupAudioPlayer(String)
    case playPauseAudio
    case play
    case stopAudio
    case rewindAudio
    case forwardAudio
    case seekAudio(TimeInterval)
    case setPlaybackRate(Float)
    case startDragging
    case stopDragging
    case updateCurrentTime(TimeInterval)
    case selectBook(Int)
    case selectChapter(Int)
    case toggleBookList(Bool)
    case updateErrorMessage(String?)
    case dismissErrorMessage
    case audioPlayerFinishedPlaying
}
