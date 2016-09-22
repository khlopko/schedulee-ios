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
    static let nowText = "сейчас".uppercased()
    static let tomorrowText = "завтра".uppercased()
}

class LessonView: UIView {

    fileprivate let titleLabel = UILabel() ->> LessonView.initialize(titleLabel:)
    fileprivate let roomLabel = UILabel() ->> LessonView.initialize(roomLabel:)
    fileprivate let lectorLabel = UILabel() ->> LessonView.initialize(lectorLabel:)
    fileprivate let startTime = UILabel() ->> LessonView.initialize(periodLabel:)
    fileprivate let endTime = UILabel() ->> LessonView.initialize(periodLabel:)
    fileprivate let indicatorLabel = UILabel() ->> LessonView.initialize(indicatorLabel:)
    fileprivate let progressLine = UIView() ->> LessonView.initialize(progressLine:)
    fileprivate let lineRounder = CircleView() ->> LessonView.initialize(lineRounder:)

    var viewModel: CurrentLessonViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            backgroundColor = viewModel.backgroundColor
            titleLabel.textColor = viewModel.titleColor
            titleLabel.font = viewModel.titleFont
            inscriptionLabels.forEach {
                $0.font = viewModel.inscriptionFont
                $0.textColor = viewModel.inscriptionColor
            }
            progressLine.backgroundColor = viewModel.progressColor
            lineRounder.fillColor = viewModel.progressColor
            setNeedsLayout()
        }
    }
    
    var lesson: Lesson? {
        didSet { updateView() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.white
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
        setNeedsLayout()
    }
}

// MARK: - Layout

private extension LessonView {
    
    func layoutNow() {
        guard let viewModel = viewModel else { return }
        let width = Constant.nowText.width(font: viewModel.inscriptionFont)
        let height = ceil(viewModel.inscriptionFont.lineHeight)
        indicatorLabel.frame = CGRect(
            x: bounds.width - Constant.inset - width,
            y: Constant.inset + minTitleHeight * 0.5 - height * 0.5,
            width: width,
            height: height)
    }
    
    func layoutInfoViews() {
        guard let viewModel = viewModel else { return }
        let width = indicatorLabel.frame.minX - Constant.inset
        let topShift = Constant.inset * 0.25
        let infoViews = [titleLabel, lectorLabel, roomLabel]
        let heights = [
            titleLabel.text?.height(for: width, font: viewModel.titleFont) ?? minTitleHeight,
            ceil(viewModel.inscriptionFont.lineHeight),
            ceil(viewModel.inscriptionFont.lineHeight)
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
//        let pastPercents = CGFloat(lesson?.pastPercents ?? 0)
//        let height: CGFloat = 20
//        let side = pastPercents > 0 ? height : 0
//        progressLine.frame = CGRect(
//            x: 0,
//            y: bounds.height - height,
//            width: bounds.width * pastPercents,
//            height: height)
//        lineRounder.frame = CGRect(
//            x: progressLine.frame.width - height * 0.5,
//            y: 0,
//            width: side,
//            height: side)
    }
    
    func layoutStartEndTime() {
        guard let viewModel = viewModel else { return }
        let startTimeWidth = ceil(startTime.text?.width(font: viewModel.inscriptionFont) ?? 0)
        let endTimeWidth = ceil(endTime.text?.width(font: viewModel.inscriptionFont) ?? 0)
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
        guard let viewModel = viewModel else { return 0 }
        return ceil(viewModel.titleFont.lineHeight)
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
    var inscriptionLabels: [UILabel] {
        return [
            roomLabel, lectorLabel, startTime, endTime, indicatorLabel,
        ]
    }
    var viewsToHide: [UIView] {
        return [progressLine, lineRounder]
    }
}

// MARK: - Init subviews

private extension LessonView {
    
    static func initialize(titleLabel: UILabel) {
        titleLabel.textColor = Color.doublePearlLusta
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    static func initialize(roomLabel: UILabel) {
        roomLabel.textColor = Color.beige
    }
    
    static func initialize(lectorLabel: UILabel) {
        lectorLabel.textColor = Color.beige
    }
    
    static func initialize(periodLabel: UILabel) {
        periodLabel.textColor = Color.beige
    }
    
    static func initialize(indicatorLabel: UILabel) {
        indicatorLabel.textColor = Color.beige
        indicatorLabel.text = Constant.nowText
    }
    
    static func initialize(progressLine: UIView) {
        progressLine.backgroundColor = Color.doublePearlLusta
    }
    
    static func initialize(lineRounder: CircleView) {
        lineRounder.fillColor = Color.doublePearlLusta
    }
}
