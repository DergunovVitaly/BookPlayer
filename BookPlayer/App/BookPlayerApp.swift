//
//  BookPlayerApp.swift
//  BookPlayer
//
//  Created by Vitaliy on 17.07.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct BookPlayerApp: App {
    var body: some Scene {
            WindowGroup {
                AudioBookPlayerView(
                    store: Store(
                        initialState: AudioPlayerState(),
                        reducer: audioPlayerReducer,
                        environment: AudioPlayerEnvironment(mainQueue: DispatchQueue.main.eraseToAnyScheduler())
                    )
                )
            }
        }
}
