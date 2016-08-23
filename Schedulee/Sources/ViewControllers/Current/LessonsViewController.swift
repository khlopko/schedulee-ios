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

    private weak var contentView: LessonsView?
    
    private var currentLesson: Lesson
    private var days: [[Lesson]] = []
    private var current = 0
    
    init(currentLesson: Lesson) {
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
        while current < 7 {
            ServerClient.instance.loadLessons(
                on: Date(),
                success: { [weak self] in
                    self?.days.append($0)
                    self?.current += 1
                },
                failure: { log.e($0) })
        }
        collection?.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        return 7
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
}

// MARK: - Private computed properties

private extension LessonsViewController {
    
    var collection: UICollectionView? {
        return contentView?.collection
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
        navigationItem.title = Text.today.rawValue
        navigationItem.setLeftButton(
            withTitle: "Назад", target: self, action: #selector(handle(back:)))
    }
}
