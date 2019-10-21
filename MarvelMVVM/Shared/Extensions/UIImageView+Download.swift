//
//  UIImageView+Download.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 7/29/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func downloadImage(withURL URLString: String) {
        if let url = URL(string: URLString) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    self.alpha = 0.5
                    UIView.animate(withDuration: 0.5) {
                        self.image = UIImage(data: data!)
                        self.alpha = 1
                        self.layoutIfNeeded()
                    }
                }
            }.resume()
        }
    }
}
