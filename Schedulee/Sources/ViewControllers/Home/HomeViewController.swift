//
//  HomeViewController.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Models
import ServerClient
import Tools

class HomeViewController: ViewController {
    
    fileprivate var contentView: HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.header.settings.addTarget(
            self, action: #selector(handle(settings:)), for: .touchUpInside)
        contentView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: - Actions
    
    func handle(settings: UIButton) {
        router?.present(route: .settings)
    }
}

// MARK: - HomeViewDelegate

extension HomeViewController: HomeViewDelegate {
    
    func handleTimetable(onHomeView view: HomeView) {
        router?.push(route: .timetable)
    }
    
    func handleLectors(onHomeView view: HomeView) {
        router?.push(route: .lectors)
    }
    
    func handleCurrentLesson(onHomeView view: HomeView) {
        router?.push(route: .lessons(current: nil))
    }
}

// MARK: - Private computed properties 

private extension HomeViewController {
    
    var currentLesson: LessonView? {
        return contentView.currentLesson
    }
}
