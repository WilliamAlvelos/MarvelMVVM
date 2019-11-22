//
//  HeroComicsCollectionViewCell.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 10/9/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import UIKit

class HeroComicsCollectionViewCell: UICollectionViewCell {

    //*************************************************
    // MARK: - IBOutlets
    //*************************************************

    @IBOutlet private weak var comicsImageView: UIImageView!
    @IBOutlet private weak var comicsTitleLabel: UILabel!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************

    var viewModel: HeroComicsCollectionViewModel!
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func prepareForReuse() {
        super.prepareForReuse()
        comicsImageView.image = nil
    }
}

//*************************************************
// MARK: - Public Methods
//*************************************************

extension HeroComicsCollectionViewCell {
    func setup(withViewModel viewModel: HeroComicsCollectionViewModel!) {
        self.viewModel = viewModel
        comicsImageView.downloadImage(withURL: viewModel.thumbnail)
        comicsTitleLabel.text = viewModel.title
    }
}
