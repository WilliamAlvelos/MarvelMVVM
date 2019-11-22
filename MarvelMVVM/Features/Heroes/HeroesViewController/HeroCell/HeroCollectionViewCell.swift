//
//  HeroCollectionViewCell.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 7/26/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {

    //*************************************************
    // MARK: - IBOutlets
    //*************************************************
    
    @IBOutlet private weak var heroView: UIView!
    @IBOutlet private weak var heroNameLabel: UILabel!
    @IBOutlet private weak var heroImageView: UIImageView!
        
    //*************************************************
    // MARK: - Life cycle
    //*************************************************

    override func prepareForReuse() {
        super.prepareForReuse()
        self.heroImageView.image = nil
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************

    func config(with hero: HeroModel) {
        self.heroNameLabel.text = hero.name
        self.heroImageView.downloadImage(withURL: hero.thumbnail.fullPath)
    }
}
