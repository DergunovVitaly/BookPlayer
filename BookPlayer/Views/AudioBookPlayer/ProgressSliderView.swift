//
//  ProgressSliderView.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import SwiftUI

struct ProgressSliderView: View {
    @ObservedObject var audioPlayer: AudioPlayer

    var body: some View {
        VStack {
            HStack {
                Text(audioPlayer.currentTime.stringFromTimeInterval())
                    .frame(width: 50, alignment: .leading)
                    .foregroundColor(.gray)
                GeometryReader { geometry in
                    Slider(value: Binding(
                        get: { audioPlayer.currentTime },
                        set: { newValue in audioPlayer.currentTime = newValue }
                    ), in: 0...audioPlayer.playerDuration(), onEditingChanged: { editing in
                        if editing {
                            audioPlayer.startDragging()
                        } else {
                            audioPlayer.stopDragging()
                            Task {
                                await audioPlayer.seekAudio(to: audioPlayer.currentTime)
                                await audioPlayer.play()
                            }
                        }
                    })
                    .padding(.top, 4)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                audioPlayer.startDragging()
                                let location = value.location.x
                                let percentage = min(max(location / geometry.size.width, 0), 1)
                                let newTime = percentage * audioPlayer.playerDuration()
                                DispatchQueue.main.async {
                                    audioPlayer.currentTime = newTime
                                }
                            }
                            .onEnded { value in
                                audioPlayer.stopDragging()
                                let location = value.location.x
                                let percentage = min(max(location / geometry.size.width, 0), 1)
                                let newTime = percentage * audioPlayer.playerDuration()
                                Task {
                                    await audioPlayer.seekAudio(to: newTime)
                                    await audioPlayer.play()
                                }
                            }
                    )
                }
                .frame(height: 40)
                Text(audioPlayer.playerDuration().stringFromTimeInterval())
                    .frame(width: 50, alignment: .trailing)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    ProgressSliderView(audioPlayer: AudioPlayer())
}
