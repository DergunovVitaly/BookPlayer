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
    var showBookList = false
    var selectedBookIndex = 0
    var selectedChapterIndex = 0
    var currentFile: String?
    var playerDuration: TimeInterval = 0.0
}

