//
//  LessonView.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Models
import Tools

fileprivate struct Constant {
    
    static let inset: CGFloat = 20
    static let titleFont = Font.regular.withSize(27)
    static let roomFont = Font.regular.withSize(15)
    static let nowFont = Font.light.withSize(13)
    static let nowText = "зараз!".uppercased()
}

class LessonView: UIView {

    private let titleLabel = UILabel() ->> LessonView.initialize(titleLabel:)
    private let roomLabel = UILabel() ->> LessonView.initialize(roomLabel:)
    private let lectorLabel = UILabel() ->> LessonView.initialize(lectorLabel:)
    private let periodLabel = UILabel() ->> LessonView.initialize(periodLabel:)
    private let now = UILabel() ->> LessonView.initialize(now:)
    private let progressLine = UIView() ->> LessonView.initialize(progressLine:)
    private let lineRounder = CircleView() ->> LessonView.initialize(lineRounder:)

    var lesson: Lesson? {
        didSet { updateView() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        all.forEach(addSubview)
        progressLine.addSubview(lineRounder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutNow()
        layoutTitleLabel()
        layoutRoomLabel()
        layoutProgressLine()
    }
}

private extension LessonView {
    
    func updateView() {
        let title = "Введення до курсу комп'ютерних наук"
        titleLabel.text = title
        setNeedsLayout()
    }
}

private extension LessonView {
    
    func layoutNow() {
        let width = Constant.nowText.width(font: Constant.nowFont)
        let height = ceil(Constant.nowFont.lineHeight)
        now.frame = CGRect(
            x: bounds.width - Constant.inset - width,
            y: Constant.inset + minTitleHeight * 0.5 - height * 0.5,
            width: width,
            height: height)
    }
    
    func layoutTitleLabel() {
        let x = Constant.inset
        let width = now.frame.minX - x
        let height = titleLabel.text?.height(for: width, font: Constant.titleFont) ?? minTitleHeight
        titleLabel.frame = CGRect(
            x: x,
            y: Constant.inset,
            width: width,
            height: height)
    }
    
    func layoutRoomLabel() {
        roomLabel.frame = CGRect(
            x: titleLabel.frame.minX,
            y: titleLabel.frame.maxY + Constant.inset * 0.25,
            width: titleLabel.frame.width,
            height: ceil(Constant.roomFont.lineHeight))
    }
    
    func layoutProgressLine() {
        let height: CGFloat = 20
        progressLine.frame = CGRect(
            x: 0,
            y: bounds.height - height,
            width: bounds.width * 0.57,
            height: height)
        lineRounder.frame = CGRect(
            x: progressLine.frame.width - height * 0.5,
            y: 0,
            width: height,
            height: height)
    }
    
    var minTitleHeight: CGFloat {
        return ceil(Constant.titleFont.lineHeight)
    }
}

private extension LessonView {
 
    var all: [UIView] {
        return [titleLabel, roomLabel, lectorLabel, periodLabel, now, progressLine]
    }
}

private extension LessonView {
    
    static func initialize(titleLabel: UILabel) {
        titleLabel.font = Constant.titleFont
        titleLabel.textColor = Color.midnightBlue
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    static func initialize(roomLabel: UILabel) {
        roomLabel.text = "2-406"
        roomLabel.textColor = Color.dodgerBlue
        roomLabel.font = Constant.roomFont
    }
    
    static func initialize(lectorLabel: UILabel) {
        lectorLabel.text = "Дивний доктор"
        lectorLabel.textColor = Color.dodgerBlue
    }
    
    static func initialize(periodLabel: UILabel) {
        periodLabel.text = "10:30 - 11:20"
        periodLabel.textColor = Color.dodgerBlue
    }
    
    static func initialize(now: UILabel) {
        now.text = Constant.nowText
        now.textColor = Color.carrotOrange
        now.font = Constant.nowFont
    }
    
    static func initialize(progressLine: UIView) {
        progressLine.backgroundColor = Color.amber
    }
    
    static func initialize(lineRounder: CircleView) {
        lineRounder.fillColor = Color.amber
    }
}
