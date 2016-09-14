//
//  Text.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

public enum Text: String {
    
    case lectors = "Преподаватели"
    case timetable = "Рассписание"
    
    case today = "Сегодня"
    case tomorrow = "Завтра"
    case yesterday = "Вчера"
    
    case monday = "Понедельник"
    case tuesday = "Вторник"
    case wednesday = "Среда"
    case thursday = "Четверг"
    case friday = "Пятница"
    case saturday = "Суббота"
    case sunday = "Воскресение"
    
    var value: String {
        return rawValue
    }
}

// MARK: - UI extensions

public extension UILabel {
    
    var textValue: Text? {
        get { return Text(rawValue: text ?? "") }
        set { text = newValue?.value }
    }
}

public extension UITextView {
    
    var textValue: Text? {
        get { return Text(rawValue: text ?? "") }
        set { text = newValue?.value }
    }
}

public extension UIButton {
    
    func setTitle(_ title: Text?, for state: UIControlState) {
        setTitle(title?.value, for: state)
    }
}
