//
//  BookListView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct BookListView: View {
    let store: Store<AudioPlayerState, AudioPlayerAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    ForEach(AudioBookModel.allBooks.indices, id: \.self) { bookIndex in
                        Section(header: Text(AudioBookModel.allBooks[bookIndex].title)) {
                            ForEach(AudioBookModel.allBooks[bookIndex].chapters.indices, id: \.self) { chapterIndex in
                                Button(action: {
                                    viewStore.send(.selectBook(bookIndex))
                                    viewStore.send(.selectChapter(chapterIndex))
                                    viewStore.send(.setupAudioPlayer(AudioBookModel.allBooks[bookIndex].chapters[chapterIndex].audioFileName))
                                    viewStore.send(.play)
                                }) {
                                    Text(AudioBookModel.allBooks[bookIndex].chapters[chapterIndex].title)
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("Select Book and Chapter", displayMode: .inline)
            }
        }
    }
}
