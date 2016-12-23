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
import Localization

// MARK: - File constants

private struct Constant {
    static let itemHeight: CGFloat = 210
    static let interItemSpace: CGFloat = 5
}

// MARK: - DayCell

class DayCell: UICollectionViewCell {
    
    private let scroll: UIScrollView = ViewFactory.make(filledWith: .clear)
    private let items = [
        DayCell.makeLessonView(),
        DayCell.makeLessonView(),
        DayCell.makeLessonView(),
        DayCell.makeLessonView(),
        DayCell.makeLessonView(),
        DayCell.makeLessonView(),
    ]
    private let emptyLabel = UILabel()
    
    private var lessons: [Lesson] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        emptyLabel.textColor = UIColor.unnamed14.withAlphaComponent(0.85)
        emptyLabel.font = Font.regular.withSize(19)
        emptyLabel.textAlignment = .center
        emptyLabel.text = Localized.noLessons
        emptyLabel.isHidden = true
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

    // MARK: - Init subviews

    private static func makeLessonView() -> LessonView {
        let lessonView = LessonView()
        lessonView.isHidden = true
        lessonView.viewModel = CurrentLessonViewModel(
            titleColor: .unnamed15, inscriptionColor: .unnamed15,
            backgroundColor: .unnamed13 , progressColor: .unnamed15,
            titleFont: Font.regular.withSize(26), inscriptionFont: Font.regular.withSize(14))
        return lessonView
    }
}
