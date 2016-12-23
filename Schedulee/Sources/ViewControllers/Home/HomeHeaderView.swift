//
//  HomeHeaderView.swift
//  Schedulee
//
//  Created on 8/14/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

final class HomeHeaderView: HeaderView {

    let settings = HomeHeaderView.makeButton(imageName: "ic_keyboard_arrow_down")
    let loop = HomeHeaderView.makeButton(imageName: "ic_loop")

    override init(frame: CGRect) {
        super.init(frame: frame)
        [settings, loop].forEach(addSubview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let views = [settings, loop]
        let side: CGFloat = 20
        var prevFrame: CGRect?
        var x: CGFloat
        for view in views {
            x = (prevFrame?.minX ?? bounds.width) - side - 10
            view.frame = CGRect(x: x, y: 32, width: side, height: side)
            prevFrame = view.frame
        }
    }
    
    private static func makeButton(imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = .unnamed14
        return button
    }
}
