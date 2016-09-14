//
//  LectorsViewController.swift
//  Schedulee
//
//  Created on 8/16/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Models
import ServerClient
import Tools

class LectorsViewController: ViewController, SlideViewControllerAnimatorProtocol {

    fileprivate(set) weak var transitionView: UIView?
    fileprivate(set) var expandViewBackgroundColor: UIColor?
    fileprivate(set) var slideText: String?
    fileprivate(set) var slideTextFont: UIFont?
    fileprivate(set) var slideTextColor: UIColor?
    var mainView: UIView { return view }
    
    fileprivate weak var contentView: LectorsView?
    
    fileprivate var lectors: [Lector] = []
    
    override func loadView() {
        let contentView = LectorsView()
        self.contentView = contentView
        view = contentView
        transitionView = navigationController?.navigationBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        ServerClient.instance.loadLectors(
            success: { [weak self] in
                self?.lectors = $0
                self?.table?.reloadData()
            },
            failure: { log.e($0) })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Actions

extension LectorsViewController {
    
    func handle(back: UIBarButtonItem) {
        transitionView = navigationController?.navigationBar
        router?.back()
    }
}

// MARK: - UITableViewDataSource

extension LectorsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lectors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: LectorCell.reuseId, for: indexPath) as! LectorCell
        cell.update(with: lectors[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension LectorsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

private extension LectorsViewController {
    
    var table: UITableView? {
        return contentView?.table
    }
}

private extension LectorsViewController {
    
    func initView() {
        setupNavigation()
        table?.register(LectorCell.self, forCellReuseIdentifier: LectorCell.reuseId)
        table?.dataSource = self
        table?.delegate = self
    }
    
    func setupNavigation() {
        let backgroundColor = Color.zanah
        let title = Text.lectors.rawValue
        let font = Font.regular.withSize(21)
        let color = Color.beige
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.decorateTitle(font: font, color: color)
        navigationItem.title = title
        navigationItem.setLeftButton(
            withTitle: "Назад", style: .light, target: self, action: #selector(handle(back:)))
        expandViewBackgroundColor = backgroundColor
        slideText = navigationItem.title
        slideTextFont = font
        slideTextColor = color
    }
}
