//
//  AudioPlayerReducer.swift
//  BookPlayer
//
//  Created by Vitaliy on 23.07.2024.
//

import ComposableArchitecture

let audioPlayerReducer = Reducer<AudioPlayerState, AudioPlayerAction, AudioPlayerEnvironment> { state, action, environment in
    switch action {
    case .setupAudioPlayer(let fileName):
        // Здесь можно интегрировать логику настройки AVAudioPlayer и установить продолжительность плеера
        state.errorMessage = nil
        // Пример:
        state.playerDuration = 300 // Замените на фактическую продолжительность
        return .none
        
    case .playPauseAudio:
        state.isPlaying.toggle()
        return .none
        
    case .play:
        state.isPlaying = true
        return .none
        
    case .stopAudio:
        state.isPlaying = false
        state.currentTime = 0.0
        return .none
        
    case .rewindAudio:
        state.currentTime -= 10
        if state.currentTime < 0 { state.currentTime = 0 }
        return .none
        
    case .forwardAudio:
        state.currentTime += 10
        // This should check against the audio duration
        return .none
        
    case .seekAudio(let time):
        state.currentTime = time
        return .none
        
    case .setPlaybackRate(let rate):
        state.playbackRate = rate
        return .none
        
    case .startDragging:
        state.isPlaying = false
        return .none
        
    case .stopDragging:
        state.isPlaying = true
        return .none
        
    case .updateCurrentTime(let time):
        state.currentTime = time
        return .none
        
    case .selectBook(let index):
        state.selectedBookIndex = index
        return .none
        
    case .selectChapter(let index):
        state.selectedChapterIndex = index
        return .none
        
    case .toggleBookList:
        state.showBookList.toggle()
        return .none
        
    case .updateErrorMessage(let message):
        state.errorMessage = message.map(IdentifiableString.init(value:))
        return .none
        
    case .audioPlayerFinishedPlaying:
        state.isPlaying = false
        state.currentTime = 0.0
        return .none
    }
}
