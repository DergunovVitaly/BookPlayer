//
//  PlaybackControlsView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI

fileprivate struct Constants {
    static let backward = "backward.end.fill"
    static let gobackward = "gobackward.5"
    static let pause = "pause.fill"
    static let play = "play.fill"
    static let goforward = "goforward.10"
    static let forward = "forward.end.fill"
}

struct PlaybackControlsView: View {
    
    @ObservedObject var audioPlayer: AudioPlayer
    @Binding var selectedChapterIndex: Int
    
    let totalChapters: Int
    let previousChapter: () -> Void
    let nextChapter: () -> Void
    
    var body: some View {
        HStack(spacing: 40) {
            Button(action: {
                withAnimation(.easeInOut) {
                    self.previousChapter()
                }
            }) {
                Image(systemName: Constants.backward)
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .disabled(selectedChapterIndex == 0)
            .foregroundColor(selectedChapterIndex == 0 ? .gray : .black)
            .scaleEffect(selectedChapterIndex == 0 ? 1.0 : 1.1)

            Button(action: {
                withAnimation(.easeInOut) {
                    DispatchQueue.main.async {
                        Task {
                            await self.audioPlayer.rewindAudio()
                        }
                    }
                }
            }) {
                Image(systemName: Constants.gobackward)
                    .resizable()
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 25, height: 25)
            }
            .scaleEffect(1.1)

            Button(action: {
                withAnimation(.easeInOut) {
                    DispatchQueue.main.async {
                        Task {
                            await self.audioPlayer.playPauseAudio()
                        }
                    }
                }
            }) {
                Image(systemName: self.audioPlayer.isPlaying ? Constants.pause : Constants.play)
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 40, height: 40)
                    .transition(.scale)
                    .animation(.easeInOut(duration: 0.3), value: audioPlayer.isPlaying)
            }
            .scaleEffect(audioPlayer.isPlaying ? 1.1 : 1.0)

            Button(action: {
                withAnimation(.easeInOut) {
                    DispatchQueue.main.async {
                        Task {
                            await self.audioPlayer.forwardAudio()
                        }
                    }
                }
            }) {
                Image(systemName: Constants.goforward)
                    .resizable()
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 25, height: 25)
            }
            .scaleEffect(1.1)

            Button(action: {
                withAnimation(.easeInOut) {
                    self.nextChapter()
                }
            }) {
                Image(systemName: Constants.forward)
                    .resizable()
                    .bold()
                    .frame(width: 20, height: 20)
            }
            .disabled(selectedChapterIndex == totalChapters - 1)
            .foregroundColor(selectedChapterIndex == totalChapters - 1 ? .gray : .black)
            .scaleEffect(selectedChapterIndex == totalChapters - 1 ? 1.0 : 1.1)
        }
        .padding(.bottom, 40)
        .animation(.easeInOut, value: selectedChapterIndex)
        .animation(.easeInOut, value: audioPlayer.isPlaying)
    }
}

#Preview {
    PlaybackControlsView(audioPlayer: AudioPlayer(), selectedChapterIndex: .constant(1), totalChapters: 2, previousChapter: {}, nextChapter: {})
}
