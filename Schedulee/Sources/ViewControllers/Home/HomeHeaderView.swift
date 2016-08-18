//
//  HomeHeaderView.swift
//  Schedulee
//
//  Created on 8/14/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

class HomeHeaderView: HeaderView {

    let settings = UIButton() ->> HomeHeaderView.initialize(settings:)

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
        settings.frame = CGRect(x: bounds.width - side - 10, y: 0, width: side, height: side)
    }
}

private extension HomeHeaderView {
    
    var all: [UIView] {
        return [settings]
    }
}

private extension HomeHeaderView {
    
    static func initialize(settings: UIButton) {
        settings.setImage(UIImage(named: "ic_settings"), for: .normal)
    }
}
