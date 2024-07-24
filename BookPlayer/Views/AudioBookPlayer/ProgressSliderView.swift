//
//  ProgressSliderView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI
import ComposableArchitecture

struct ProgressSliderView: View {
    let viewStore: ViewStore<AudioPlayerState, AudioPlayerAction>

    var body: some View {
        VStack {
            HStack {
                Text(viewStore.currentTime.stringFromTimeInterval())
                    .frame(width: 50, alignment: .leading)
                    .foregroundColor(.gray)
                GeometryReader { geometry in
                    Slider(value: viewStore.binding(
                        get: \.currentTime,
                        send: AudioPlayerAction.seekAudio
                    ), in: 0...viewStore.playerDuration, onEditingChanged: { editing in
                        if editing {
                            viewStore.send(.startDragging)
                        } else {
                            viewStore.send(.stopDragging)
                            viewStore.send(.play)
                        }
                    })
                    .padding(.top, 4)
                }
                .frame(height: 40)
                Text(viewStore.playerDuration.stringFromTimeInterval())
                    .frame(width: 50, alignment: .trailing)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
        }
    }
}
