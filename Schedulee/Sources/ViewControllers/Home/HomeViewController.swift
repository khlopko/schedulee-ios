//
//  HomeViewController.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI

class HomeViewController: ViewController {

    private weak var contentView: HomeView?
    
    override func loadView() {
        let contentView = HomeView()
        self.contentView = contentView
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView?.delegate = self
        contentView?.currentLesson.lesson = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: - HomeViewDelegate

extension HomeViewController: HomeViewDelegate {
    
    func handleTimetable(onHomeView view: HomeView) {
        router?.push(route: .timetable, from: navigationController)
    }
    
    func handleLectors(onHomeView view: HomeView) {
        router?.push(route: .lectors, from: navigationController)
    }
    
    func handleCurrentLesson(onHomeView view: HomeView) {
        guard let lesson = currentLesson?.lesson else { return }
        router?.push(route: .lessons(current: lesson), from: navigationController)
    }
}

// MARK: - Private computed properties 

private extension HomeViewController {
    
    var currentLesson: LessonView? {
        return contentView?.currentLesson
    }
}
