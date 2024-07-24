//
//  IdentifiableString.swift
//  BookPlayer
//
//  Created by Vitaliy on 23.07.2024.
//

import Foundation

struct IdentifiableString: Identifiable, Equatable {
    var id: String { self.value }
    let value: String
    
    static func == (lhs: IdentifiableString, rhs: IdentifiableString) -> Bool {
        return lhs.value == rhs.value
    }
}
