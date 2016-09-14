//
//  CircleView.swift
//  Schedulee
//
//  Created on 8/14/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit

public final class CircleView: UIView {

    private(set) var path: UIBezierPath!
    
    public var fillColor = Color.clear {
        didSet { setNeedsDisplay() }
    }
    
    public override func draw(_ rect: CGRect) {
        path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
