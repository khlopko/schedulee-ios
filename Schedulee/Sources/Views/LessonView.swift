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
    static let smallInset: CGFloat = 10
    static let titleFont = Font.regular.withSize(27)
    static let roomFont = Font.regular.withSize(15)
    static let timeFont = Font.light.withSize(14)
    static let nowFont = Font.light.withSize(13)
    static let nowText = "сейчас!".uppercased()
}

class LessonView: UIView {

    private let titleLabel = UILabel() ->> LessonView.initialize(titleLabel:)
    private let roomLabel = UILabel() ->> LessonView.initialize(roomLabel:)
    private let lectorLabel = UILabel() ->> LessonView.initialize(lectorLabel:)
    private let startTime = UILabel() ->> LessonView.initialize(periodLabel:)
    private let endTime = UILabel() ->> LessonView.initialize(periodLabel:)
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
        layoutInfoViews()
        layoutProgressLine()
        layoutStartEndTime()
    }
}

private extension LessonView {
    
    func updateView() {
        guard let lesson = lesson else { return }
        titleLabel.text = lesson.title
        roomLabel.text = lesson.room
        lectorLabel.text = lesson.lector.fullname
        startTime.text = DateDecorator.time(from: lesson.start)
        endTime.text = DateDecorator.time(from: lesson.end)
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
    
    func layoutInfoViews() {
        let width = now.frame.minX - Constant.inset
        let topShift = Constant.inset * 0.25
        let infoViews = [titleLabel, lectorLabel, roomLabel]
        let heights = [
            titleLabel.text?.height(for: width, font: Constant.titleFont) ?? minTitleHeight,
            ceil(Constant.roomFont.lineHeight),
            ceil(Constant.roomFont.lineHeight)
        ]
        var prevFrame: CGRect?
        for (view, height) in zip(infoViews, heights) {
            let y: CGFloat
            if let prevFrame = prevFrame {
                y = prevFrame.maxY + topShift
            } else {
                y = Constant.inset
            }
            view.frame = CGRect(x: Constant.inset, y: y, width: width, height: height)
            prevFrame = view.frame
        }
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
    
    func layoutStartEndTime() {
        let startTimeWidth = ceil(startTime.text?.width(font: Constant.timeFont) ?? 0)
        let endTimeWidth = ceil(endTime.text?.width(font: Constant.timeFont) ?? 0)
        let height: CGFloat = 20
        let y = progressLine.frame.minY - height - Constant.smallInset
        startTime.frame = CGRect(
            x: Constant.inset,
            y: y,
            width: startTimeWidth,
            height: height)
        endTime.frame = CGRect(
            x: bounds.width - endTimeWidth - Constant.inset,
            y: y,
            width: endTimeWidth,
            height: height)
    }
    
    var minTitleHeight: CGFloat {
        return ceil(Constant.titleFont.lineHeight)
    }
}

private extension LessonView {
 
    var all: [UIView] {
        return [titleLabel, roomLabel, lectorLabel, startTime, endTime, now, progressLine]
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
        roomLabel.textColor = Color.dodgerBlue
        roomLabel.font = Constant.roomFont
    }
    
    static func initialize(lectorLabel: UILabel) {
        lectorLabel.textColor = Color.dodgerBlue
        lectorLabel.font = Constant.roomFont
    }
    
    static func initialize(periodLabel: UILabel) {
        periodLabel.textColor = Color.carrotOrange
        periodLabel.font = Constant.timeFont
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
