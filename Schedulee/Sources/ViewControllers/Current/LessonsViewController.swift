//
//  LessonsViewController.swift
//  Schedulee
//
//  Created on 8/16/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Models
import ServerClient
import Tools

class LessonsViewController: ViewController {

    fileprivate weak var contentView: LessonsView?
    
    fileprivate var currentLesson: Lesson?
    fileprivate var days = [[Lesson]](repeating: [], count: 7)
    fileprivate var current = 0
    
    init(currentLesson: Lesson? = nil) {
        self.currentLesson = currentLesson
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let contentView = LessonsView()
        self.contentView = contentView
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        indicator?.startAnimating()
        WebClient.instance.loadLessons(
            groupId: UserSettings.default.currentGroupID,
            success: { [weak self] lessons in
                self?.handleLessons(lessons)
                self?.indicator?.stopAnimating()
            },
            failure: { log.e($0) })
    }
    
    private func handleLessons(_ lessons: [Lesson]) {
        for index in 0..<days.count {
            days[index] = lessons.filter { $0.dayOfWeek == Lesson.DayOfWeek(rawValue: index) }
        }
        let currentIndex = Calendar.current.component(.weekdayOrdinal, from: Date()) - 1
        navigationItem.title = dayDescr[currentIndex]
        let indexPath = IndexPath(row: currentIndex, section: 0)
        collection?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        collection?.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        log.d("exec")
    }
}

// MARK: - Actions

extension LessonsViewController {
    
    func handle(back: UIButton) {
        router?.back()
    }
}

// MARK: - UICollectionViewDataSource

extension LessonsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DayCell.reuseId, for: indexPath) as! DayCell
        cell.update(with: days[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LessonsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let apprxIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        let index = min(max(0, apprxIndex), days.count - 1)
        navigationItem.title = dayDescr[index]
    }
}

let dayDescr = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]

// MARK: - Private computed properties

private extension LessonsViewController {
    
    var collection: UICollectionView? {
        return contentView?.collection
    }
    var indicator: UIActivityIndicatorView? {
        return contentView?.indicator
    }
    var flowLayout: UICollectionViewFlowLayout? {
        return collection?.collectionViewLayout as? UICollectionViewFlowLayout
    }
}

// MARK: - Private support

private extension LessonsViewController {
    
    func initView() {
        setupNavigation()
        collection?.register(DayCell.self, forCellWithReuseIdentifier: DayCell.reuseId)
        collection?.dataSource = self
        collection?.delegate = self
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Color.bossanova
        navigationController?.navigationBar.decorateTitle(
            font: Font.regular.withSize(21),
            color: Color.doublePearlLusta)
        navigationItem.setLeftButton(
            withTitle: "Назад", target: self, action: #selector(handle(back:)))
    }
}
