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

fileprivate struct Constant {
    
    static let verticalLineDistances: [CGFloat] = [50, 75, 175]
    static let firstHorizontalTopShift: CGFloat = 150
    static let horizontalLineDistance: CGFloat = 75
}

class SplashView: UIView {

    let verticalLines = [
        SplashView.makeLine(),
        SplashView.makeLine(),
        SplashView.makeLine(),
    ]
    let horizontalLines = [
        SplashView.makeLine(),
        SplashView.makeLine(),
        SplashView.makeLine(),
        SplashView.makeLine(),
    ]
    private var previousBounds: CGRect = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.mainDark
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
}

private extension SplashView {
    
    func layoutVerticalLines() {
        var prevFrame: CGRect?
        var x: CGFloat = 0
        for (line, distance) in zip(verticalLines, Constant.verticalLineDistances) {
            x = (prevFrame?.maxX ?? 0) + distance
            line.frame = CGRect(x: x, y: 0, width: 15, height: 0)
            prevFrame = line.frame
        }
    }
    
    func layoutHorizontalLines() {
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
}

private extension SplashView {
    
    static func makeLine() -> UIView {
        return UIView() ->> {
            $0.backgroundColor = Color.mainLight
        }
    }
}
