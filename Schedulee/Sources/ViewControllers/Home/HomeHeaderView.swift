//
//  HomeHeaderView.swift
//  Schedulee
//
//  Created on 8/14/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

fileprivate struct Constant {
    static let inset: CGFloat = 10
}

class HomeHeaderView: HeaderView {

    fileprivate let settings = HomeHeaderView.makeButton(imageName: "ic_keyboard_arrow_down")
    fileprivate let loop = HomeHeaderView.makeButton(imageName: "ic_loop")

    override init(frame: CGRect) {
        super.init(frame: frame)
        all.forEach(addSubview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let side: CGFloat = 44
        var prevFrame: CGRect?
        var x: CGFloat
        for view in all {
            x = (prevFrame?.minX ?? bounds.width) - side
            view.frame = CGRect(x: x, y: 20, width: side, height: side)
            prevFrame = view.frame
        }
    }
}

fileprivate extension HomeHeaderView {
    
    var all: [UIView] {
        return [settings, loop]
    }
}

fileprivate extension HomeHeaderView {
    
    static func makeButton(imageName: String) -> UIButton {
        return UIButton(type: .custom) ->> {
            $0.setImage(UIImage(named: imageName), for: .normal)
            $0.tintColor = Color.bossanova
        }
    }
}
