//
//  ViewFactories.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 12/22/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit

public struct ViewFactory {
    
    public static func make<View: UIView>(filledWith color: UIColor) -> View {
        let view = View()
        view.backgroundColor = color
        return view
    }
    
    public struct Label {
        
        public typealias View = UILabel
        
        public static var properties = Properties(
            textColor: .unnamed15,
            font: Font.regular.withSize(14),
            textAlignment: .left)
        
        public static func make(text: String = "",
                                filledWith color: UIColor = .clear,
                                textColor: UIColor = properties.textColor,
                                font: UIFont = properties.font,
                                textAlignment: NSTextAlignment = properties.textAlignment) -> View {
            let view: View = ViewFactory.make(filledWith: color)
            view.text = text
            view.textColor = textColor
            view.font = font
            view.textAlignment = textAlignment
            return view
        }
        
        public struct Properties {
            var textColor: UIColor
            var font: UIFont
            var textAlignment: NSTextAlignment
        }
    }
}
