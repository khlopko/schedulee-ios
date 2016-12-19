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

    let table = LectorsView.makeTable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.beige
        all.forEach(addSubview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        table.frame = bounds
    }
    
    private var all: [UIView] {
        return [table]
    }
    
    private static func makeTable() -> UITableView {
        let table = UITableView()
        table.allowsMultipleSelection = false
        table.backgroundColor = .clear
        table.tableFooterView = UIView()
        table.separatorInset = .zero
        table.separatorColor = Color.zanah
        return table
    }
}
