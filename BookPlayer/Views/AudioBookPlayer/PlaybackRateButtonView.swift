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
    @Binding var playbackRate: Double
    let changePlaybackRate: () -> Void
    
    var body: some View {
        Button(action: {
            self.changePlaybackRate()
        }) {
            Text(Localization.speed + "\(String(format: Constants.textFormat, playbackRate))")
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

#Preview {
    PlaybackRateButtonView(playbackRate: .constant(1.3), changePlaybackRate: {})
}
