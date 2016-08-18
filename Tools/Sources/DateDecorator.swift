//
//  DateDecorator.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

private let minutesHoursFormat = "hh:mm"

private let formatter = DateFormatter() ->> {
    $0.dateFormat = minutesHoursFormat
}

public final class DateDecorator {
    
    public static func time(from date: Date) -> String {
        return formatter.string(from: date)
    }
}
