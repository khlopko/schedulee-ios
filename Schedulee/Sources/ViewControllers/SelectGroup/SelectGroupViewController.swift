//
//  SelectGroupViewController.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 9/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import ServerClient
import Models
import Tools

final class SelectGroupViewController: ViewController {

    private var contentView: SelectGroupView {
        return view as! SelectGroupView
    }
    
    private var table: UITableView {
        return contentView.table
    }
    private var indicator: UIActivityIndicatorView {
        return contentView.indicator
    }
    
    fileprivate var groups: [Group] = []
    fileprivate var selectedIndex: Int? {
        didSet { navigationItem.rightBarButtonItem?.isEnabled = selectedIndex != nil }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SelectGroupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(SelectCell.self, forCellReuseIdentifier: SelectCell.reuseId)
        table.dataSource = self
        table.delegate = self
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = .mainLight
        navigationItem.title = .selectGroup
        navigationController?.navigationBar.decorateTitle(
            font: Font.regular.withSize(21), color: .mainDark)
        let save = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        save.setTitle(.save, for: .normal)
        save.sizeToFit()
        save.setTitleColor(.mainDark, for: .normal)
        save.titleLabel?.font = Font.regular.withSize(14)
        save.addTarget(self, action: #selector(handle(save:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: save)
        navigationItem.rightBarButtonItem?.isEnabled = false
        indicator.startAnimating()
        GroupsConfiguration().task.resume(
            success: { [weak self] groups in
                self?.groups = groups
                self?.table.reloadData()
                self?.indicator.stopAnimating()
            },
            failure: { [weak self] error in
                self?.indicator.stopAnimating()
                ErrorNotification.show(with: error)
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func handle(save: UIBarButtonItem) {
        UserSettings.default.currentGroupID = groups[selectedIndex!].id
        router?.changeRootViewController(to: HomeViewController(), animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SelectGroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectCell.reuseId, for: indexPath) as! SelectCell
        cell.group = groups[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SelectGroupViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
}
