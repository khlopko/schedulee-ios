//
//  LectorsView.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

class LectorsView: UIView {

    let table = UITableView() ->> LectorsView.initialize(table:)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.white
        all.forEach(addSubview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        table.frame = bounds
    }
}

private extension LectorsView {
    
    var all: [UIView] {
        return [table]
    }
}

private extension LectorsView {
    
    static func initialize(table: UITableView) {
        table.allowsMultipleSelection = false
        table.tableFooterView = UIView()
        table.separatorInset = .zero
        table.separatorColor = Color.whiteBlue
    }
}
