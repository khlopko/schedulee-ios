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

    let table = UITableView() ->> {
        $0.tableFooterView = UIView()
        $0.backgroundColor = Color.mainLight
        $0.separatorInset = .zero
        $0.separatorColor = Color.secondaryDark
    }
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge) ->> {
        $0.hidesWhenStopped = true
        $0.color = Color.mainDark
    }

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
