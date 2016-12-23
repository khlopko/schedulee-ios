//
//  TimetableViewController.swift
//  Schedulee
//
//  Created on 8/16/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools
import Localization

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
        let backgroundColor: UIColor = .doublePearlLusta
        let font = Font.regular.withSize(21)
        let color: UIColor = .bossanova
        let text = Localized.timetable
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.decorateTitle(font: font, color: color)
        navigationItem.title = text
        navigationItem.setLeftButton(
            withTitle: .back, style: .dark, target: self, action: #selector(handle(back:)))
    }
}
