//
//  UINavigationBar+Styling.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Tools

public extension UINavigationBar {
    
    func decorateTitle(font: UIFont, color: UIColor){
        titleTextAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: color,
        ]
    }
}

public extension UINavigationItem {

    func setLeftButton(withTitle title: String,
                       style: Style = .light,
                       target: AnyObject,
                       action: Selector) {
        leftBarButtonItem = UIBarButtonItem(customView:
            makeButton(title: title, style: style, target: target, action: action))
    }
    
    func setRightButton(withTitle title: String,
                        style: Style = .light,
                        target: AnyObject, 
                        action: Selector) {
        rightBarButtonItem = UIBarButtonItem(customView:
            makeButton(title: title, style: style, target: target, action: action))
    }
}

public extension UINavigationItem {
    
    public enum Style {
        
        case dark
        case light
        
        var color: UIColor {
            switch self {
            case .dark: return Color.midnightBlue
            case .light: return Color.whiteBlue
            }
        }
    }
}

private func makeButton(title: String,
                        style: UINavigationItem.Style,
                        target: AnyObject, 
                        action: Selector) -> UIButton {
    let font = Font.regular.withSize(14)
    let width = ceil(title.width(font: font))
    return UIButton(frame: CGRect(x: 0, y: 0, width: width, height: 44)) ->> {
        $0.addTarget(target, action: action, for: .touchUpInside)
        $0.setTitle(title, for: .normal)
        $0.setTitleColor(style.color, for: .normal)
        $0.titleLabel?.font = font
    }
}
