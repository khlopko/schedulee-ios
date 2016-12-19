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
    
    fileprivate weak var contentView: HomeView?
    
    override func loadView() {
        let contentView = HomeView()
        self.contentView = contentView
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView?.delegate = self
        GroupsConfiguration().task.resume(
            success: { groups in
                log.d(groups)
            },
            failure: { error in
                log.e(error)
            })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        router?.push(route: .lessons(current: nil), from: navigationController)
    }
}

// MARK: - Private computed properties 

private extension HomeViewController {
    
    var currentLesson: LessonView? {
        return contentView?.currentLesson
    }
}
