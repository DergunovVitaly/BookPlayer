//
//  ChapterTitleView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI

struct ChapterTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.caption)
            .foregroundColor(.black)
    }
}

#Preview {
    ChapterTitleView(title: "Chapter title")
}
