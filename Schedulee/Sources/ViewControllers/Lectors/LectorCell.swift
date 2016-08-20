//
//  LectorCell.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/19/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Models
import Tools

// MARK: - File constants

fileprivate struct Constant {
    static let inset: CGFloat = 10
}

// MARK: - LectorCell

class LectorCell: UITableViewCell {
    
    private let photoView = UIImageView() ->> LectorCell.initialize(photoView:)
    private let fullnameLabel = UILabel() ->> LectorCell.initialize(fullnameLabel:)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        all.forEach(addSubview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutPhotoView()
        layoutFullnameLabel()
    }
}

extension LectorCell {
    
    func update(with lector: Lector) {
        fullnameLabel.text = lector.fullname
    }
}

// MARK: - Private computed properties

private extension LectorCell {
    
    var all: [UIView] {
        return [photoView, fullnameLabel]
    }
}

// MARK: - Layout

private extension LectorCell {
    
    func layoutPhotoView() {
        let side = contentView.bounds.height - Constant.inset * 2
        photoView.frame = CGRect(x: Constant.inset, y: Constant.inset, width: side, height: side)
    }
    
    func layoutFullnameLabel() {
        let x = photoView.frame.maxX + Constant.inset
        fullnameLabel.frame = CGRect(
            x: x,
            y: Constant.inset,
            width: bounds.width - x - Constant.inset,
            height: photoView.frame.height)
    }
}

// MARK: - Init subviews

private extension LectorCell {
    
    static func initialize(photoView: UIImageView) {
        photoView.contentMode = .center
        photoView.clipsToBounds = true
        photoView.backgroundColor = Color.amber
    }
    
    static func initialize(fullnameLabel: UILabel) {
        fullnameLabel.font = Font.regular.withSize(18)
        fullnameLabel.textColor = Color.midnightBlue
    }
}
