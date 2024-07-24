//
//  ContentView.swift
//  BookPlayer
//
//  Created by Vitaliy on 17.07.2024.
//

import SwiftUI
import ComposableArchitecture

fileprivate struct Constants {
    static let playbackRates = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0]
}

struct AudioBookPlayerView: View {
    let store: Store<AudioPlayerState, AudioPlayerAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Spacer()
                CoverImageView()
                    .padding(.top, 30)
                    .frame(width: 300, height: 400)
                
                BookTitleView(title: AudioBookModel.allBooks[viewStore.selectedBookIndex].title)
                
                ChapterTitleView(title: AudioBookModel.allBooks[viewStore.selectedBookIndex].chapters[viewStore.selectedChapterIndex].title)
                
                ChapterProgressView(selectedChapterIndex: viewStore.selectedChapterIndex, totalChapters: AudioBookModel.allBooks[viewStore.selectedBookIndex].chapters.count)
                    .padding(.top, 3)
                
                ProgressSliderView(viewStore: viewStore)
                
                PlaybackRateButtonView(playbackRate: viewStore.binding(
                    get: \.playbackRate,
                    send: AudioPlayerAction.setPlaybackRate
                ))
                
                PlaybackControlsView(viewStore: viewStore, totalChapters: AudioBookModel.allBooks[viewStore.selectedBookIndex].chapters.count)
                
                BookListButtonView(showBookList: viewStore.binding(
                    get: \.showBookList,
                    send: AudioPlayerAction.toggleBookList
                ))
                .sheet(isPresented: viewStore.binding(
                    get: \.showBookList,
                    send: AudioPlayerAction.toggleBookList
                )) {
                    BookListView(store: store)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(red: 1.0, green: 0.972, blue: 0.955))
            .alert(item: viewStore.binding(
                get: \.errorMessage,
                send: { .updateErrorMessage($0?.value) }
            )) { message in
                Alert(title: Text(message.value), dismissButton: .default(Text("OK")))
            }
        }
    }
}
