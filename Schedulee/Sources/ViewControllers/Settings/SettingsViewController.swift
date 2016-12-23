//
//  SettingsViewController.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 12/23/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit
import CustomUI

final class SettingsViewController: ViewController {
    
    private var contentView: SettingsView {
        return view as! SettingsView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .coverVertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.setLeftButton(withTitle: .back, target: self, action: #selector(handle(back:)))
    }
    
    // MARK: - Actions
    
    func handle(back: UIButton) {
        router?.back()
    }
}
