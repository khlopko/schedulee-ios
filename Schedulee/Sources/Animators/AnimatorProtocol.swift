//
//  AnimatorProtocol.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/23/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit

protocol AnimatorProtocol: class {
    func validate(from fromViewController: UIViewController,
                  to toViewController: UIViewController) -> Bool
}
