//
//  CustomView.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 10/9/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import Foundation
import UIKit

/// This class may help you to create custom views, don't forget to reference the content view.
class CustomView: UIView {

    //*************************************************
    // MARK: - IBOutlets
    //*************************************************

    @IBOutlet private var contentView: UIView!

    //*************************************************
    // MARK: - Inits
    //*************************************************

    public override init(frame: CGRect) {
        self.contentView = UIView()
        super.init(frame: frame)
        configView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.contentView = UIView()
        super.init(coder: aDecoder)
        configView()
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func configView() {
        let className = String(describing: type(of: self))
        Bundle.main.loadNibNamed(className, owner: self, options: nil)
        addSubview(contentView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
