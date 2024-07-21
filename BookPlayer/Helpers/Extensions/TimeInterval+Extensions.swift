//
//  TimeInterval+Ext.swift
//  BookPlayer
//
//  Created by Vitaliy on 20.07.2024.
//

import Foundation

fileprivate struct Constants {
    static let timeIntervalFormat = "%0.2d:%0.2d"
}

extension TimeInterval {
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        return String(format: Constants.timeIntervalFormat, minutes, seconds)
    }
}
