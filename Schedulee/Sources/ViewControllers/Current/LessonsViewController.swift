//
//  LessonsViewController.swift
//  Schedulee
//
//  Created on 8/16/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit
import Models

class LessonsViewController: ViewController {

    private var currentLesson: Lesson
    
    init(currentLesson: Lesson) {
        self.currentLesson = currentLesson
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
