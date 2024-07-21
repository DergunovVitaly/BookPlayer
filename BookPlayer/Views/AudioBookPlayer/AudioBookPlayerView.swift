//
//  ContentView.swift
//  BookPlayer
//
//  Created by Vitaliy on 17.07.2024.
//

import SwiftUI
import AVFoundation

fileprivate struct Constants {
    static let playbackRates = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0]
}

struct AudioBookPlayerView: View {
    @ObservedObject private var audioPlayer = AudioPlayer()
    @State private var selectedBookIndex = 0
    @State private var selectedChapterIndex = 0
    @State private var playbackRate = 1.0
    @State private var showBookList = false
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    
    let books = AudioBookModel.allBooks
    let playbackRates: [Double] = Constants.playbackRates
    
    var body: some View {
        VStack {
            Spacer()
            CoverImageView()
                .padding(.top, 30)
                .frame(width: 300, height: 400)
            
            BookTitleView(title: books[selectedBookIndex].title)
            
            ChapterTitleView(title: books[selectedBookIndex].chapters[selectedChapterIndex].title)
            
            ChapterProgressView(selectedChapterIndex: selectedChapterIndex, totalChapters: books[selectedBookIndex].chapters.count)
                .padding(.top, 3)
            ProgressSliderView(audioPlayer: audioPlayer)
            
            PlaybackRateButtonView(playbackRate: $playbackRate, changePlaybackRate: changePlaybackRate)
            
            PlaybackControlsView(audioPlayer: audioPlayer, selectedChapterIndex: $selectedChapterIndex, totalChapters: books[selectedBookIndex].chapters.count, previousChapter: previousChapter, nextChapter: nextChapter)
            
            BookListButtonView(showBookList: $showBookList)
                .sheet(isPresented: $showBookList) {
                    BookListView(selectedBookIndex: $selectedBookIndex, selectedChapterIndex: $selectedChapterIndex, audioPlayer: audioPlayer, books: books, dismiss: { self.showBookList = false })
                }
            Spacer()
        }
        .padding()
        .background(Color(red: 1.0, green: 0.972, blue: 0.955))
        .onAppear {
            Task {
                await self.audioPlayer.setupAudioPlayer(with: books[selectedBookIndex].chapters[selectedChapterIndex].audioFileName)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage), dismissButton: .default(Text(Localization.ok)))
        }
        .onChange(of: audioPlayer.errorMessage) {
            handleErrorMessageChange(audioPlayer.errorMessage ?? Localization.unknownError)
        }
    }
    
    private func changePlaybackRate() {
        if let currentIndex = playbackRates.firstIndex(of: playbackRate), currentIndex < playbackRates.count - 1 {
            playbackRate = playbackRates[currentIndex + 1]
        } else {
            playbackRate = playbackRates.first ?? 1.0
        }
        Task {
            await audioPlayer.setPlaybackRate(to: Float(playbackRate))
        }
    }
    
    private func previousChapter() {
        if selectedChapterIndex > 0 {
            selectedChapterIndex -= 1
            Task {
                await audioPlayer.setupAudioPlayer(with: books[selectedBookIndex].chapters[selectedChapterIndex].audioFileName)
                await audioPlayer.play()
            }
        }
    }
    
    private func nextChapter() {
        if selectedChapterIndex < books[selectedBookIndex].chapters.count - 1 {
            selectedChapterIndex += 1
            Task {
                await audioPlayer.setupAudioPlayer(with: books[selectedBookIndex].chapters[selectedChapterIndex].audioFileName)
                await audioPlayer.play()
            }
        }
    }
    
    private func handleErrorMessageChange(_ newErrorMessage: String?) {
        if let errorMessage = newErrorMessage {
            alertMessage = errorMessage
            showAlert = true
            Task {
                await self.audioPlayer.stopAudio()
            }
        }
    }
}

struct AudioBookPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioBookPlayerView()
    }
}
