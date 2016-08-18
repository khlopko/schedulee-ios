//
//  LectorsViewController.swift
//  Schedulee
//
//  Created on 8/16/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

class LectorsViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
}

private extension LectorsViewController {
    
    func initView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = Color.midnightBlue
    }
}
