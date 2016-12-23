//
//  HomeView.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools
import Localization

// MARK: - HomeViewDelegate

protocol HomeViewDelegate: class {
    
    func handleTimetable(onHomeView view: HomeView)
    func handleLectors(onHomeView view: HomeView)
    func handleCurrentLesson(onHomeView view: HomeView)
}

// MARK: - HomeView

class HomeView: UIView {

    weak var delegate: HomeViewDelegate?
    
    let header: HomeHeaderView = ViewFactory.make(filledWith: .unnamed15)
    let timetable = HomeView.makeButton(
        text: .timetable, backgroundColor: .unnamed11, titleColor: .unnamed15)
    let lectors = HomeView.makeButton(
        text: .lectors, backgroundColor: .unnamed13, titleColor: .unnamed15)
    let currentLesson = HomeView.makeCurrentLesson()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        all.forEach(addSubview)
        zip(buttons, actions).forEach { $0.0.addTarget(self, action: $0.1, for: .touchUpInside) }
        addTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let k: CGFloat = 0.4
        let itemsHeight: CGFloat = bounds.height - 64
        let currentLessonHeight = itemsHeight * k
        let buttonHeight = itemsHeight * (1 - k) * 0.5
        let heights = [64, currentLessonHeight, buttonHeight, buttonHeight]
        var prevFrame: CGRect?
        for (view, height) in zip(all, heights) {
            let y = prevFrame?.maxY ?? 0
            view.frame = CGRect(x: 0, y: y, width: bounds.width, height: height)
            prevFrame = view.frame
        }
    }

    // MARK: - Actions
    
    func handle(tap: UITapGestureRecognizer) {
        delegate?.handleCurrentLesson(onHomeView: self)
    }
    
    func handle(timetable: UIButton) {
        delegate?.handleTimetable(onHomeView: self)
    }
    
    func handle(lectors: UIButton) {
        delegate?.handleLectors(onHomeView: self)
    }

    // MARK: - Gestures
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(handle(tap:)))
        currentLesson.addGestureRecognizer(tap)
    }

    // MARK: - Private computed properties
    
    private var all: [UIView] {
        return [header, currentLesson, lectors, timetable]
    }
    private var buttons: [UIButton] {
        return [timetable, lectors]
    }
    private var actions: [Selector] {
        return [#selector(handle(timetable:)), #selector(handle(lectors:))]
    }

    // MARK: - Init subviews
    
    private static func makeButton(text: String, backgroundColor: UIColor, titleColor: UIColor) -> UIButton {
        let button = UIButton()
        button.backgroundColor = backgroundColor
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = Font.regular.withSize(25)
        button.setTitleColor(titleColor, for: .normal)
        return button
    }
    
    private static func makeCurrentLesson() -> LessonView {
        let currentLesson = LessonView()
        currentLesson.viewModel = CurrentLessonViewModel(
            titleColor: .unnamed14, inscriptionColor: .unnamed14,
            backgroundColor: .unnamed15, progressColor: .unnamed14,
            titleFont: Font.regular.withSize(26), inscriptionFont: Font.regular.withSize(14))
        return currentLesson
    }
}
