//
//  Reusable.swift
//  MarvelMVVM
//
//  Created by AndreLO on 24/10/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import UIKit

protocol Reusable { }

extension Reusable {
    
    /// Returns the UINib with the name of the class.
    static var nib: UINib {
        let name = String(describing: Self.self)
        guard let reference = self as? AnyClass else {
            fatalError("Error getting the class implementing Reusable protocol.")
        }
        
        let bundle = Bundle(for: reference)
        return UINib(nibName: name, bundle: bundle)
    }
    
    /// Returns the identifier based on the name of the class.
    static var identifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: Reusable { }

extension UITableViewHeaderFooterView: Reusable { }

extension UICollectionViewCell: Reusable { }
