//
//  ReusableViewProtocol.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/19/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit

public protocol ReusableViewProtocol: class {
    static var reuseId: String { get }
}

extension ReusableViewProtocol {
    
    public static var reuseId: String {
        let reuseId = NSStringFromClass(self)
        return reuseId
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
}

extension UITableViewCell: ReusableViewProtocol {
}
