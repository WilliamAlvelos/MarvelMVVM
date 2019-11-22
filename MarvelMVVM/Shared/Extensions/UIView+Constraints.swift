//
//  UIView+Constraints.swift
//  MarvelMVVM
//
//  Created by AndreLO on 24/10/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Pins the view in a superview using autolayout.
    ///
    /// - Parameter parent: superview to pin the current view.
    func pinEdges(to parent: UIView) {
        DispatchQueue.main.async {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
            self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        }
    }
}
