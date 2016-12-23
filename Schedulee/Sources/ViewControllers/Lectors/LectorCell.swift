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

private struct Constant {
    static let inset: CGFloat = 10
}

// MARK: - LectorCell

class LectorCell: UITableViewCell {
    
    private let photoView = LectorCell.makePhotoView()
    private let fullnameLabel = ViewFactory.Label.make(textColor: .eastBay, font: Font.regular.withSize(18))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
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
    
    func update(with lector: Lector) {
        fullnameLabel.text = lector.fullname
    }

    // MARK: - Private computed properties
    
    private var all: [UIView] {
        return [photoView, fullnameLabel]
    }

    // MARK: - Layout
    
    private func layoutPhotoView() {
        let side = contentView.bounds.height - Constant.inset * 2
        photoView.frame = CGRect(x: Constant.inset, y: Constant.inset, width: side, height: side)
    }
    
    private func layoutFullnameLabel() {
        let x = photoView.frame.maxX + Constant.inset
        fullnameLabel.frame = CGRect(
            x: x,
            y: Constant.inset,
            width: bounds.width - x - Constant.inset,
            height: photoView.frame.height)
    }

    // MARK: - Init subviews
    
    private static func makePhotoView() -> UIImageView {
        let photoView: UIImageView = ViewFactory.make(filledWith: .zanah)
        photoView.contentMode = .center
        photoView.clipsToBounds = true
        return photoView
    }
}
