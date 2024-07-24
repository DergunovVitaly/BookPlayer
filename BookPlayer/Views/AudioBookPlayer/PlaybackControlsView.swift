//
//  PlaybackControlsView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI
import ComposableArchitecture

fileprivate struct Constants {
    static let backward = "backward.end.fill"
    static let gobackward = "gobackward.10"
    static let pause = "pause.fill"
    static let play = "play.fill"
    static let goforward = "goforward.10"
    static let forward = "forward.end.fill"
}

struct PlaybackControlsView: View {
    let viewStore: ViewStore<AudioPlayerState, AudioPlayerAction>
    let totalChapters: Int
    
    var body: some View {
        HStack(spacing: 40) {
            Button(action: {
                if viewStore.selectedChapterIndex > 0 {
                    viewStore.send(.selectChapter(viewStore.selectedChapterIndex - 1))
                }
            }) {
                Image(systemName: Constants.backward)
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .disabled(viewStore.selectedChapterIndex == 0)
            .foregroundColor(viewStore.selectedChapterIndex == 0 ? .gray : .black)
            .scaleEffect(viewStore.selectedChapterIndex == 0 ? 1.0 : 1.1)

            Button(action: {
                viewStore.send(.rewindAudio)
            }) {
                Image(systemName: Constants.gobackward)
                    .resizable()
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 25, height: 25)
            }
            .scaleEffect(1.1)

            Button(action: {
                viewStore.send(.playPauseAudio)
            }) {
                Image(systemName: viewStore.isPlaying ? Constants.pause : Constants.play)
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 40, height: 40)
                    .transition(.scale)
            }
            .scaleEffect(viewStore.isPlaying ? 1.1 : 1.0)

            Button(action: {
                viewStore.send(.forwardAudio)
            }) {
                Image(systemName: Constants.goforward)
                    .resizable()
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 25, height: 25)
            }
            .scaleEffect(1.1)

            Button(action: {
                if viewStore.selectedChapterIndex < totalChapters - 1 {
                    viewStore.send(.selectChapter(viewStore.selectedChapterIndex + 1))
                }
            }) {
                Image(systemName: Constants.forward)
                    .resizable()
                    .bold()
                    .frame(width: 20, height: 20)
            }
            .disabled(viewStore.selectedChapterIndex == totalChapters - 1)
            .foregroundColor(viewStore.selectedChapterIndex == totalChapters - 1 ? .gray : .black)
            .scaleEffect(viewStore.selectedChapterIndex == totalChapters - 1 ? 1.0 : 1.1)
        }
        .padding(.bottom, 40)
    }
}
