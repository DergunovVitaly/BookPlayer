//
//  ChapterProgressView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI

struct ChapterProgressView: View {
    let selectedChapterIndex: Int
    let totalChapters: Int
    
    var body: some View {
        Text(String(format: Localization.keyPoint, selectedChapterIndex + 1, totalChapters))
            .font(.caption)
            .bold()
            .foregroundColor(.gray)
            .padding(.bottom, 5)
    }
}

#Preview {
    ChapterProgressView(selectedChapterIndex: 1, totalChapters: 3)
}
