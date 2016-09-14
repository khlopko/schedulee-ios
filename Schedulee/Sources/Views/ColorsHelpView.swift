//
//  ColorsHelpView.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/23/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import CustomUI
import Tools

class ColorsHelpView: UIView {
    
    let table = UITableView(frame: .zero, style: .grouped) ->> ColorsHelpView.initialize(table:)
    
    private static func initialize(table: UITableView) {
        table.allowsMultipleSelection = false
        table.allowsSelection = false
        table.backgroundColor = .clear
        table.bounces = false
        table.separatorColor = .clear
        table.tableFooterView = UIView()
        table.tableHeaderView = UIView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseId)
    }
    
    private var startPoint: CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(table)
        table.dataSource = self
        table.delegate = self
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: #selector(handle(pan:)))
        addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        table.frame = bounds
        table.frame.origin.y += 20
        table.frame.size.height -= 20
    }
    
    func handle(pan: UIPanGestureRecognizer) {
        let point = pan.location(in: self)
        if let startPoint = startPoint {
            let rtl = point.x < startPoint.x
            if rtl && fabs(startPoint.x) - fabs(point.x)  > frame.width * 0.35 {
                frame.origin.x = -frame.width
            }
        } else {
            startPoint = point
        }
    }
}

extension ColorsHelpView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Color.allColors.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Color.allColors[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseId, for: indexPath)
        let color = Color.allColors[indexPath.section][indexPath.row]
        cell.backgroundColor = color
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = Font.regular.withSize(16)
        cell.textLabel?.text = "(\(color.components.map{"\($0)"}.joined(separator: ", ")))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 128
    }
}

private extension UIColor {
    
    var components: [CGFloat] {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return [
            round(red * 255),
            round(green * 255),
            round(blue * 255),
            round(alpha),
        ]
    }
}
