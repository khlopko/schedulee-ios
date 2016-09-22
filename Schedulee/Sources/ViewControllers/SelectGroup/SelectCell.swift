//
//  SelectCell.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 9/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Models

final class SelectCell: UITableViewCell {
    
    var group: Group? {
        didSet {
            textLabel?.text = group?.title
            textLabel?.font = Font.regular.withSize(16)
            textLabel?.textColor = Color.secondaryDark
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = selected ? Color.secondaryDark : .clear
        textLabel?.textColor = selected ? Color.mainLight : Color.secondaryDark
    }
}
