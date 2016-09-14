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

class HomeViewController: ViewController, SlideViewControllerAnimatorProtocol {

    fileprivate(set) weak var transitionView: UIView?
    fileprivate(set) var expandViewBackgroundColor: UIColor?
    fileprivate(set) var slideText: String?
    fileprivate(set) var slideTextFont: UIFont?
    fileprivate(set) var slideTextColor: UIColor?
    var mainView: UIView { return view }
    
    fileprivate weak var contentView: HomeView?
    
    override func loadView() {
        let contentView = HomeView()
        self.contentView = contentView
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log.d("exec")
        contentView?.delegate = self
        ServerClient.instance.loadLessons(
            on: Date(),
            success: { lessons in
                log.i(lessons)
            },
            failure: { error in
                log.e(error)
        })
        /*ServerClient.instance.getCurrentLesson(
            success: { [weak self] in self?.contentView?.currentLesson.lesson = $0 },
            failure: { log.e($0) })*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - HomeViewDelegate

extension HomeViewController: HomeViewDelegate {
    
    func handleTimetable(onHomeView view: HomeView) {
        updateAnimationProperties(view: view.timetable, label: view.timetable.titleLabel)
        router?.push(route: .timetable, from: navigationController)
    }
    
    func handleLectors(onHomeView view: HomeView) {
        updateAnimationProperties(view: view.lectors, label: view.lectors.titleLabel)
        router?.push(route: .lectors, from: navigationController)
    }
    
    func handleCurrentLesson(onHomeView view: HomeView) {
        updateAnimationProperties(view: view.currentLesson, label: nil)
        router?.push(route: .lessons(current: nil), from: navigationController)
    }
    
    private func updateAnimationProperties(view: UIView?, label: UILabel?) {
        transitionView = view
        expandViewBackgroundColor = view?.backgroundColor
        slideText = label?.text
        slideTextFont = label?.font
        slideTextColor = label?.textColor
    }
}

// MARK: - Private computed properties 

private extension HomeViewController {
    
    var currentLesson: LessonView? {
        return contentView?.currentLesson
    }
}
