//
//  PlaybackRateButtonView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI

fileprivate struct Constants {
    static let textFormat = "%.2f"
}

struct PlaybackRateButtonView: View {
    @Binding var playbackRate: Float
    
    var body: some View {
        Button(action: {
            // Handle playback rate change
        }) {
            Text("Speed: \(String(format: Constants.textFormat, playbackRate))")
                .foregroundStyle(.black)
                .bold()
                .font(.system(size: 14))
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
        .padding(.bottom, 40)
    }
}
