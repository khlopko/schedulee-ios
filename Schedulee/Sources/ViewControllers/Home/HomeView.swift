//
//  HomeView.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

// MARK: - HomeViewDelegate

protocol HomeViewDelegate: class {
    
    func handleTimetable(onHomeView view: HomeView)
    func handleLectors(onHomeView view: HomeView)
    func handleCurrentLesson(onHomeView view: HomeView)
}

// MARK: - HomeView

class HomeView: UIView {

    weak var delegate: HomeViewDelegate?
    
    let timetable = HomeView.makeButton(text: .timetable, backgroundColor: Color.dodgerBlue)
    let lectors = HomeView.makeButton(text: .lectors, backgroundColor: Color.midnightBlue)
    let currentLesson = LessonView() ->> HomeView.initialize(currentLesson:)
    
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
        let currentLessonHeight = bounds.height * k
        let buttonHeight = bounds.height * (1 - k) * 0.5
        let heights = [buttonHeight, buttonHeight, currentLessonHeight]
        var prevFrame: CGRect?
        for (view, height) in zip(all, heights) {
            let y = prevFrame?.maxY ?? 0
            view.frame = CGRect(x: 0, y: y, width: bounds.width, height: height)
            prevFrame = view.frame
        }
    }
}

// MARK: - Actions

extension HomeView {
    
    func handle(tap: UITapGestureRecognizer) {
        delegate?.handleCurrentLesson(onHomeView: self)
    }
    
    func handle(timetable: UIButton) {
        delegate?.handleTimetable(onHomeView: self)
    }
    
    func handle(lectors: UIButton) {
        delegate?.handleLectors(onHomeView: self)
    }
}

// MARK: - Gestures

private extension HomeView {
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(handle(tap:)))
        currentLesson.addGestureRecognizer(tap)
    }
}

// MARK: - Private computed properties

private extension HomeView {
    
    var all: [UIView] {
        return [timetable, lectors, currentLesson]
    }
    var buttons: [UIButton] {
        return [timetable, lectors]
    }
    var actions: [Selector] {
        return [#selector(handle(timetable:)), #selector(handle(lectors:))]
    }
}

// MARK: - Init subviews

private extension HomeView {
    
    static func makeButton(text: Text, backgroundColor: UIColor) -> UIButton {
        return UIButton() ->> {
            $0.backgroundColor = backgroundColor
            $0.setTitle(text, for: .normal)
            $0.titleLabel?.font = Font.regular.withSize(29)
            $0.setTitleColor(Color.whiteBlue, for: .normal)
        }
    }
    
    static func initialize(currentLesson: LessonView) {
        currentLesson.backgroundColor = Color.whiteBlue
    }
}
