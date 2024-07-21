//
//  Localization.swift
//  BookPlayer
//
//  Created by Vitaliy on 21.07.2024.
//

import Foundation

struct Localization {
    static var speed: String { NSLocalizedString("Speed x", comment: "") }
    static var keyPoint: String { NSLocalizedString("KEY_POINT", comment: "") }
    static var audioFileNotFound: String { NSLocalizedString("audio_file_not_found", comment: "") }
    static var errorInitializingPlayer: String { NSLocalizedString("error_initializing_player", comment: "") }
    static var audioPlayerIsNotInitialized: String { NSLocalizedString("audio_player_is_not_initialized", comment: "") }
    static var selectBookAndChapter: String { NSLocalizedString("select_book_and_chapter", comment: "") }
    static var done: String { NSLocalizedString("done", comment: "") }
    static var title: String { NSLocalizedString("title", comment: "") }
    static var chapter: String { NSLocalizedString("chapter", comment: "") }
    static var unknownError: String { NSLocalizedString("unknown_error", comment: "") }
    static var ok: String { NSLocalizedString("ok", comment: "") }
}

// MARK: AudioPlayerError AudioPlayerError
enum AudioPlayerError: Error, LocalizedError {
    case fileNotFound
    case initializationFailed(Error)
    case playerNotInitialized

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return Localization.audioFileNotFound
        case .initializationFailed(let error):
            return Localization.errorInitializingPlayer + .space + error.localizedDescription
        case .playerNotInitialized:
            return Localization.audioPlayerIsNotInitialized
        }
    }
}
