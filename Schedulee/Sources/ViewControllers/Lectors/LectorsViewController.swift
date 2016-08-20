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

class LectorsViewController: ViewController {

    private weak var contentView: LectorsView?
    
    private var lectors: [Lector] = []
    
    override func loadView() {
        let contentView = LectorsView()
        self.contentView = contentView
        view = contentView
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
}

extension LectorsViewController {
    
    func handle(back: UIBarButtonItem) {
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
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Color.midnightBlue
        navigationController?.navigationBar.decorateTitle(font: Font.regular.withSize(21), color: Color.white)
        navigationItem.title = Text.lectors.rawValue
        navigationItem.setLeftButton(withTitle: "Назад", target: self, action: #selector(handle(back:)))
    }
}
