//
//  SplashView.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit
import CustomUI
import Tools

protocol View: class {
    
    associatedtype ViewClass: UIView = Self
    var content: ViewClass { get }
    
    init()
}

extension View {
    
    var content: ViewClass {
        return self as! ViewClass
    }
}

protocol SplashView: View {
    
    var verticalLines: [UIView] { get }
    var horizontalLines: [UIView] { get }
}

fileprivate struct Constant {
    
    static let verticalLineDistances: [CGFloat] = [50, 75, 175]
    static let firstHorizontalTopShift: CGFloat = 150
    static let horizontalLineDistance: CGFloat = 75
}

final class SplashViewImplementation: UIView, SplashView {

    let verticalLines = [
        SplashViewImplementation.makeLine(),
        SplashViewImplementation.makeLine(),
        SplashViewImplementation.makeLine(),
    ]
    let horizontalLines = [
        SplashViewImplementation.makeLine(),
        SplashViewImplementation.makeLine(),
        SplashViewImplementation.makeLine(),
        SplashViewImplementation.makeLine(),
    ]
    private var previousBounds: CGRect = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.unnamed14
        verticalLines.forEach(addSubview)
        horizontalLines.forEach(addSubview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if previousBounds == bounds {
            return
        }
        previousBounds = bounds
        layoutVerticalLines()
        layoutHorizontalLines()
    }
    
    private func layoutVerticalLines() {
        var prevFrame: CGRect?
        var x: CGFloat = 0
        for (line, distance) in zip(verticalLines, Constant.verticalLineDistances) {
            x = (prevFrame?.maxX ?? 0) + distance
            line.frame = CGRect(x: x, y: 0, width: 15, height: 0)
            prevFrame = line.frame
        }
    }
    
    private func layoutHorizontalLines() {
        var prevFrame: CGRect?
        var y: CGFloat = 0
        for line in horizontalLines {
            y = prevFrame == nil
                ? Constant.firstHorizontalTopShift
                : prevFrame!.maxY + Constant.horizontalLineDistance
            line.frame = CGRect(x: 0, y: y, width: 0, height: 15)
            prevFrame = line.frame
        }
    }
    
    private static func makeLine() -> UIView {
        let view = UIView()
        view.backgroundColor = Color.unnamed11
        return view
    }
}
