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
        print("setupAudioPlayer called with fileName: \(fileName)")
        state.currentFile = fileName
        state.errorMessage = nil
        state.currentTime = 0.0
        return environment.audioPlayerService.setup(fileName)
            .fireAndForget()
        
    case .playPauseAudio:
        print("playPauseAudio called, isPlaying: \(state.isPlaying), currentFile: \(String(describing: state.currentFile))")
        if state.currentFile == nil {
            let fileName = AudioBookModel.allBooks[state.selectedBookIndex].chapters[state.selectedChapterIndex].audioFileName
            print("No current file. Setting up and playing: \(fileName)")
            return Effect.concatenate(
                Effect(value: .setupAudioPlayer(fileName)),
                Effect(value: .playPauseAudio)
            )
        } else {
            if state.isPlaying {
                print("Pausing audio")
                state.isPlaying = false
                return environment.audioPlayerService.pause().fireAndForget()
            } else {
                print("Resuming audio")
                state.isPlaying = true
                return environment.audioPlayerService.play().fireAndForget()
            }
        }
        
    case .play:
        print("play called")
        state.isPlaying = true
        return environment.audioPlayerService.play().fireAndForget()
        
    case .stopAudio:
        print("stopAudio called")
        state.isPlaying = false
        state.currentTime = 0.0
        return environment.audioPlayerService.stop().fireAndForget()
        
    case .rewindAudio:
        print("rewindAudio called")
        state.currentTime -= 10
        if state.currentTime < 0 { state.currentTime = 0 }
        return environment.audioPlayerService.seek(state.currentTime).fireAndForget()
        
    case .forwardAudio:
        print("forwardAudio called")
        state.currentTime += 10
        return environment.audioPlayerService.seek(state.currentTime).fireAndForget()
        
    case .seekAudio(let time):
        print("seekAudio called")
        state.currentTime = time
        return environment.audioPlayerService.seek(time).fireAndForget()
        
    case .setPlaybackRate(let rate):
        print("setPlaybackRate called")
        state.playbackRate = rate
        return environment.audioPlayerService.setRate(rate).fireAndForget()
        
    case .startDragging:
        print("startDragging called")
        state.isPlaying = false
        return environment.audioPlayerService.pause().fireAndForget()
        
    case .stopDragging:
        print("stopDragging called")
        state.isPlaying = true
        return environment.audioPlayerService.play().fireAndForget()
        
    case .updateCurrentTime(let time):
        state.currentTime = time
        return .none
        
    case .selectBook(let index):
        state.selectedBookIndex = index
        return .none
        
    case .selectChapter(let index):
        state.selectedChapterIndex = index
        let fileName = AudioBookModel.allBooks[state.selectedBookIndex].chapters[state.selectedChapterIndex].audioFileName
        print("Selecting chapter and setting up audio for file: \(fileName)")
        return Effect.concatenate(
            Effect(value: .setupAudioPlayer(fileName)),
            Effect(value: .play),
            Effect(value: .toggleBookList)
        )
        
    case .toggleBookList:
        state.showBookList.toggle()
        return .none
        
    case .updateErrorMessage(let message):
        state.errorMessage = message.map { IdentifiableString(value: $0) }
        return .none
        
    case .audioPlayerFinishedPlaying:
        state.isPlaying = false
        state.currentTime = 0.0
        return .none
    }
}
