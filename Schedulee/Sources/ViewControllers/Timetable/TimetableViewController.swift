//
//  TimetableViewController.swift
//  Schedulee
//
//  Created on 8/16/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

class TimetableViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
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
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Color.doublePearlLusta
        navigationController?.navigationBar.decorateTitle(
            font: Font.regular.withSize(21),
            color: Color.bossanova)
        navigationItem.title = Text.timetable.rawValue
        navigationItem.setLeftButton(
            withTitle: "Назад", style: .dark, target: self, action: #selector(handle(back:)))
    }
}
