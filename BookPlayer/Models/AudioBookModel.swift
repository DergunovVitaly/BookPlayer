//
//  BookModel.swift
//  BookPlayer
//
//  Created by Vitaliy on 18.07.2024.
//

import Foundation
import ComposableArchitecture

struct Chapter: Equatable, Identifiable {
    let id = UUID()
    let title: String
    let audioFileName: String
}

struct AudioBookModel: Equatable, Identifiable {
    let id = UUID()
    let title: String
    let chapters: [Chapter]
    
    static let allBooks: [AudioBookModel] = [
        AudioBookModel(
            title: "Learn English",
            chapters: [
                Chapter(title: "Daily schedule", audioFileName: "daily-schedule"),
                Chapter(title: "Holidays", audioFileName: "holidays"),
                Chapter(title: "Jobs", audioFileName: "jobs"),
                Chapter(title: "Travel", audioFileName: "travel")
            ]
        ),
        AudioBookModel(
            title: "TOEFL",
            chapters: [
                Chapter(title: "First conversation", audioFileName: "toefl-conversation-1"),
                Chapter(title: "Second conversation", audioFileName: "toefl-conversation-2")
            ])
    ]
}
