//
//  UIViewController+Child.swift
//  MarvelMVVM
//
//  Created by AndreLO on 24/10/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController?) {
        guard let controller = child else { return }
        addChild(controller)
        controller.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
