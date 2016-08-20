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
    static let titleFont = Font.regular.withSize(26)
    static let roomFont = Font.regular.withSize(14)
    static let timeFont = Font.regular.withSize(14)
    static let nowFont = Font.regular.withSize(14)
    static let nowText = "сейчас".uppercased()
    static let tomorrowText = "завтра".uppercased()
}

class LessonView: UIView {

    private let titleLabel = UILabel() ->> LessonView.initialize(titleLabel:)
    private let roomLabel = UILabel() ->> LessonView.initialize(roomLabel:)
    private let lectorLabel = UILabel() ->> LessonView.initialize(lectorLabel:)
    private let startTime = UILabel() ->> LessonView.initialize(periodLabel:)
    private let endTime = UILabel() ->> LessonView.initialize(periodLabel:)
    private let indicatorLabel = UILabel() ->> LessonView.initialize(indicatorLabel:)
    private let progressLine = UIView() ->> LessonView.initialize(progressLine:)
    private let lineRounder = CircleView() ->> LessonView.initialize(lineRounder:)

    var lesson: Lesson? {
        didSet { updateView() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.whiteBlue
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
        indicatorLabel.text = lesson.isCurrent ? Constant.nowText : Constant.tomorrowText
        viewsToHide.forEach { $0.isHidden = !lesson.isCurrent }
        setNeedsLayout()
    }
}

// MARK: - Layout

private extension LessonView {
    
    func layoutNow() {
        let width = Constant.nowText.width(font: Constant.nowFont)
        let height = ceil(Constant.nowFont.lineHeight)
        indicatorLabel.frame = CGRect(
            x: bounds.width - Constant.inset - width,
            y: Constant.inset + minTitleHeight * 0.5 - height * 0.5,
            width: width,
            height: height)
    }
    
    func layoutInfoViews() {
        let width = indicatorLabel.frame.minX - Constant.inset
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
        let pastPercents = CGFloat(lesson?.pastPercents ?? 0)
        let height: CGFloat = 20
        let side = pastPercents > 0 ? height : 0
        progressLine.frame = CGRect(
            x: 0,
            y: bounds.height - height,
            width: bounds.width * pastPercents,
            height: height)
        lineRounder.frame = CGRect(
            x: progressLine.frame.width - height * 0.5,
            y: 0,
            width: side,
            height: side)
    }
    
    func layoutStartEndTime() {
        let startTimeWidth = ceil(startTime.text?.width(font: Constant.timeFont) ?? 0)
        let endTimeWidth = ceil(endTime.text?.width(font: Constant.timeFont) ?? 0)
        let height: CGFloat = 20
        let startY = progressLine.isHidden ? bounds.height : progressLine.frame.minY
        let y = startY - height - Constant.smallInset
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

// MARK: - Private computed properties

private extension LessonView {
 
    var all: [UIView] {
        return [
            titleLabel, roomLabel, lectorLabel,
            startTime, endTime, indicatorLabel, progressLine,
        ]
    }
    var viewsToHide: [UIView] {
        return [progressLine, lineRounder]
    }
}

// MARK: - Init subviews

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
    
    static func initialize(indicatorLabel: UILabel) {
        indicatorLabel.textColor = Color.carrotOrange
        indicatorLabel.text = Constant.nowText
        indicatorLabel.font = Constant.nowFont
    }
    
    static func initialize(progressLine: UIView) {
        progressLine.backgroundColor = Color.amber
    }
    
    static func initialize(lineRounder: CircleView) {
        lineRounder.fillColor = Color.amber
    }
}
