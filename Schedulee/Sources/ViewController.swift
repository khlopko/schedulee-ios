//
//  ViewController.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit
import Tools

class ViewController: UIViewController {
    
    override var navigationController: NavigationController? {
        return super.navigationController as? NavigationController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private weak var colorHelp: ColorsHelpView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let help = ColorsHelpView()
        help.isHidden = true
        colorHelp = help
        view.addSubview(help)
        let edge = UIScreenEdgePanGestureRecognizer()
        edge.edges = [.left]
        edge.addTarget(self, action: #selector(handle(edgePan:)))
        view.addGestureRecognizer(edge)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let shift: CGFloat = 300
        colorHelp?.frame = CGRect(x: -shift, y: 0, width: shift, height: view.bounds.height)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        colorHelp?.frame.origin.x = -(colorHelp?.frame.width ?? 0)
        colorHelp?.isHidden = true
    }
    
    func handle(edgePan: UIScreenEdgePanGestureRecognizer) {
        guard let help = colorHelp else { return }
        let point = edgePan.location(in: view)
        switch edgePan.state {
        case .began:
            help.isHidden = false
        case .changed:
            if help.frame.origin.x <= 0 {
                help.frame.origin.x = min(-(help.frame.width - point.x), 0)
            }
        case .ended:
            help.frame.origin.x = 0
        default:
            return
        }
    }
}
