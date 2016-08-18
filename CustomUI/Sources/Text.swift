//
//  Text.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public enum Text: String {
    
    case lectors = "Викладачі"
    case timetable = "Розклад"
    
    var text: String {
        return rawValue
    }
}

public extension UILabel {
    
    var textValue: Text? {
        get { return Text(rawValue: text ?? "") }
        set { text = newValue?.text }
    }
}

public extension UIButton {
    
    func setTitle(_ title: Text?, for state: UIControlState) {
        setTitle(title?.text, for: state)
    }
}
