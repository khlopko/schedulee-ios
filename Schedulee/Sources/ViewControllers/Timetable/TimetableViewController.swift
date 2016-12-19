//
//  TimetableViewController.swift
//  Schedulee
//
//  Created on 8/16/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

final class TimetableViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    // MARK: - Actions
    
    func handle(back: UIButton) {
        router?.back()
    }

    // MARK: - Private support
    
    private func initView() {
        view.backgroundColor = .white
        setupNavigation()
    }
    
    private func setupNavigation() {
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
    }
}
