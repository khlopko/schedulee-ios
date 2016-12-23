//
//  SelectGroupView.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 9/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

final class SelectGroupView: UIView {

    let table: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView()
        table.backgroundColor = .mainLight
        table.separatorInset = .zero
        table.separatorColor = .secondaryDark
        return table
    }()
    let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        view.hidesWhenStopped = true
        view.color = .mainDark
        return view
    }()

    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(table)
        table.addSubview(indicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        table.frame = bounds
        indicator.frame = table.frame
    }
}
