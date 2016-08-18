//
//  String+bounds.swift
//  Schedulee
//
//  Created on 8/14/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public extension String {
    
    func width(font: UIFont) -> CGFloat {
        let string = NSString(string: self)
        let width = string.size(attributes: [NSFontAttributeName: font]).width
        return width
    }
    
    func height(for width: CGFloat, font: UIFont) -> CGFloat {
        let inputSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let outputSize = self.boundingRect(
            with: inputSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [NSFontAttributeName: font],
            context: nil)
        return outputSize.height
    }

}
