//
//  TimetableViewController.swift
//  Schedulee
//
//  Created on 8/16/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

class TimetableViewController: ViewController, SlideViewControllerAnimatorProtocol {

    fileprivate(set) weak var transitionView: UIView?
    fileprivate(set) var expandViewBackgroundColor: UIColor?
    fileprivate(set) var slideText: String?
    fileprivate(set) var slideTextFont: UIFont?
    fileprivate(set) var slideTextColor: UIColor?
    var mainView: UIView { return view }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        transitionView = navigationController?.navigationBar
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: - Actions

extension TimetableViewController {
    
    func handle(back: UIButton) {
        router?.back()
    }
}

// MARK: - Private support

private extension TimetableViewController {
    
    func initView() {
        view.backgroundColor = .white
        setupNavigation()
    }
    
    func setupNavigation() {
        let backgroundColor = Color.doublePearlLusta
        let font = Font.regular.withSize(21)
        let color = Color.bossanova
        let text = Text.timetable.rawValue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.decorateTitle(font: font, color: color)
        navigationItem.title = text
        navigationItem.setLeftButton(
            withTitle: "Назад", style: .dark, target: self, action: #selector(handle(back:)))
        slideText = text
        slideTextFont = font
        slideTextColor = color
        expandViewBackgroundColor = backgroundColor
    }
}
