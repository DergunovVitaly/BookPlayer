//
//  AudioPlayerState.swift
//  BookPlayer
//
//  Created by Vitaliy on 23.07.2024.
//

import Foundation

struct AudioPlayerState: Equatable {
    var isPlaying = false
    var currentTime: TimeInterval = 0.0
    var playbackRate: Float = 1.0
    var errorMessage: IdentifiableString?
    var selectedBookIndex: Int = 0
    var selectedChapterIndex: Int = 0
    var showBookList = false
    var playerDuration: TimeInterval = 0.0

    static func == (lhs: AudioPlayerState, rhs: AudioPlayerState) -> Bool {
        return lhs.isPlaying == rhs.isPlaying &&
               lhs.currentTime == rhs.currentTime &&
               lhs.playbackRate == rhs.playbackRate &&
               lhs.errorMessage == rhs.errorMessage &&
               lhs.selectedBookIndex == rhs.selectedBookIndex &&
               lhs.selectedChapterIndex == rhs.selectedChapterIndex &&
               lhs.showBookList == rhs.showBookList &&
               lhs.playerDuration == rhs.playerDuration
    }
}

