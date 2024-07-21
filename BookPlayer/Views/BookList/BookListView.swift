//
//  BookListView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI

struct BookListView: View {
    @Binding var selectedBookIndex: Int
    @Binding var selectedChapterIndex: Int
    var audioPlayer: AudioPlayer
    let books: [AudioBookModel]
    let dismiss: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books.indices, id: \.self) { bookIndex in
                    Section(header: Text(self.books[bookIndex].title)) {
                        ForEach(self.books[bookIndex].chapters.indices, id: \.self) { chapterIndex in
                            Button(action: {
                                self.selectedBookIndex = bookIndex
                                self.selectedChapterIndex = chapterIndex
                                Task {
                                    await self.audioPlayer.setupAudioPlayer(with: self.books[bookIndex].chapters[chapterIndex].audioFileName)
                                    await self.audioPlayer.play()
                                    self.dismiss()
                                }
                            }) {
                                Text(self.books[bookIndex].chapters[chapterIndex].title)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Localization.selectBookAndChapter, displayMode: .inline)
        }
    }
}

#Preview {
    BookListView(selectedBookIndex: .constant(1), selectedChapterIndex: .constant(2), audioPlayer: AudioPlayer(), books: AudioBookModel.allBooks, dismiss: {})
}
