//
//  CoverImageView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI

struct CoverImageView: View {
    var body: some View {
        Image(.bookCover)
            .resizable()
            .aspectRatio(contentMode: .fill)
                   .cornerRadius(10)
                   .shadow(radius: 10)
                   .clipped()
                   .padding(.bottom, 5)
    }
}

#Preview {
    CoverImageView()
}
