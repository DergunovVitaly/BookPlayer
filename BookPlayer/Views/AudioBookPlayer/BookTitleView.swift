//
//  BookTitleView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI

struct BookTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title)
            .bold()
            .foregroundColor(.primary)
    }
}

#Preview {
    BookTitleView(title: "Book title")
}
