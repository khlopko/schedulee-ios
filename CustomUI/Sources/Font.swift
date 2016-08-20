//
//  Font.swift
//  Schedulee
//
//  Created on 8/14/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public enum Font: String {
    
    case regular = "-Regular"
    case italic = "-Italic"
    case light = "-Light"
    case bold = "-Bold"
    case thin = "-Thin"
    
    public func withSize(_ size: CGFloat) -> UIFont {
        let fontName = "Lato" + rawValue
        guard let font = UIFont(name: fontName, size: size) else {
            fatalError("Don't exist font with name \(fontName)")
        }
        return font
    }
}

// Clear Sans

// BloggerSans
// BloggerSans-Light
// BloggerSans-Bold
// BloggerSans-BoldItalic
// BloggerSans-Italic
// BloggerSans-Light
// BloggerSans-LightItalic
// BloggerSans-Medium
// BloggerSans-MediumItalic

// Phenomena
// Phenomena-Light
// Phenomena-Black
// Phenomena-Bold
// Phenomena-ExtraBold
// Phenomena-ExtraLight
// Phenomena-Thin
