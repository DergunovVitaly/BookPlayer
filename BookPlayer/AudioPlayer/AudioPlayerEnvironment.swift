//
//  AudioPlayerEnvironment.swift
//  BookPlayer
//
//  Created by Vitaliy on 23.07.2024.
//

import Foundation
import ComposableArchitecture

struct AudioPlayerEnvironment {
    var audioPlayerService: AudioPlayerService
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

