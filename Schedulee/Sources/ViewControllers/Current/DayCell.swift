//
//  LessonCell.swift
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
    static let itemHeight: CGFloat = 210
    static let interItemSpace: CGFloat = 5
}

// MARK: - DayCell

class DayCell: UICollectionViewCell {
    
    fileprivate let scroll = UIScrollView() ->> DayCell.initialize(scroll:)
    fileprivate let items = [
        LessonView() ->> DayCell.initialize(lessonView:),
        LessonView() ->> DayCell.initialize(lessonView:),
        LessonView() ->> DayCell.initialize(lessonView:),
        LessonView() ->> DayCell.initialize(lessonView:),
        LessonView() ->> DayCell.initialize(lessonView:),
        LessonView() ->> DayCell.initialize(lessonView:),
    ]
    private let emptyLabel = UILabel() ->> DayCell.initialize(emptyLabel:)
    
    fileprivate var lessons: [Lesson] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scroll)
        items.forEach(scroll.addSubview)
        scroll.addSubview(emptyLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scroll.frame = bounds
        emptyLabel.frame = scroll.frame
        var prevFrame: CGRect?
        for item in items {
            let y: CGFloat
            if let prevFrame = prevFrame {
                y = prevFrame.maxY + Constant.interItemSpace
            } else {
                y = 0
            }
            item.frame = CGRect(x: 0, y: y, width: bounds.width, height: Constant.itemHeight)
            prevFrame = item.frame
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scroll.contentOffset = .zero
    }
    
    func update(with lessons: [Lesson]) {
        self.lessons = lessons
        emptyLabel.isHidden = !lessons.isEmpty
        updateContentSize(itemsCount: lessons.count)
        for (index, item) in items.enumerated() {
            let show = index < lessons.count
            item.isHidden = !show
            if show {
                item.lesson = lessons[index]
            }
        }
    }
    
    private func updateContentSize(itemsCount: Int) {
        let count = CGFloat(itemsCount)
        let contentHeight = Constant.itemHeight * count + Constant.interItemSpace * (count - 1)
        scroll.contentSize = CGSize(width: bounds.width, height: contentHeight)
    }
}

// MARK: - Init subviews

private extension DayCell {
    
    static func initialize(scroll: UIScrollView) {
        scroll.backgroundColor = Color.clear
    }
    
    static func initialize(lessonView: LessonView) {
        lessonView.isHidden = true
        lessonView.viewModel = CurrentLessonViewModel(
            titleColor: Color.bossanova, inscriptionColor: Color.eastBay,
            backgroundColor: Color.doublePearlLusta , progressColor: Color.zanah,
            titleFont: Font.regular.withSize(26), inscriptionFont: Font.regular.withSize(14))
    }
    
    static func initialize(emptyLabel: UILabel) {
        emptyLabel.isHidden = true
        emptyLabel.font = Font.regular.withSize(19)
        emptyLabel.textColor = Color.beige.withAlphaComponent(0.85)
        emptyLabel.textAlignment = .center
        emptyLabel.text = "Занятий нет."
    }
}
