//
//  Font.swift
//  Schedulee
//
//  Created on 8/14/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public enum Font: String {
    
    case regular = "Lato-Regular"
    case italic = "Lato-Italic"
    case light = "Lato-Light"
    case bold = "Lato-Bold"
    case thin = "Lato-Thin"
    
    public func withSize(_ size: CGFloat) -> UIFont {
        let fontName = rawValue
        guard let font = UIFont(name: fontName, size: size) else {
            fatalError("Don't exist font with name \(fontName)")
        }
        return font
    }
}
