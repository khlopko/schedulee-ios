//
//  Localized.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 12/23/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public typealias Localized = String

public extension Localized {
    
    // MARK: - B
    static let back = localizedString(byKey: "Back")
    
    // MARK: - F
    static let friday = localizedString(byKey: "Friday")
    
    // MARK: - L
    static let lectors = localizedString(byKey: "Lectors")
    
    // MARK: - M
    static let monday = localizedString(byKey: "Monday")
    
    // MARK: - N
    static let now = localizedString(byKey: "Now")
    static let noLessons = localizedString(byKey: "NoLessonsText")
    
    // MARK: - S
    static let saturday = localizedString(byKey: "Saturday")
    static let save = localizedString(byKey: "Save")
    static let selectGroup = localizedString(byKey: "SelectGroupTitle")
    static let sunday = localizedString(byKey: "Sunday")
    
    // MARK: - T
    static let thursday = localizedString(byKey: "Thursday")
    static let timetable = localizedString(byKey: "Timetable")
    static let today = localizedString(byKey: "Today")
    static let tomorrow = localizedString(byKey: "Tomorromw")
    static let tuesday = localizedString(byKey: "Tuesday")
    
    // MARK: - U
    static let undefinedError = localizedString(byKey: "UndefinedErrorText")
    
    // MARK: - W
    static let wednesday = localizedString(byKey: "Wednesday")
    
    // MARK: - Y
    static let yesterday = localizedString(byKey: "Yesterday")
}

private func localizedString(byKey key: String) -> String {
    let localized = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
    return localized
}
