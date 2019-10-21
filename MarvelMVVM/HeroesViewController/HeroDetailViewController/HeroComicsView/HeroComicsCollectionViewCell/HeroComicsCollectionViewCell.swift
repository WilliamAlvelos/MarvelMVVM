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
    
    func setup(with comic: ComicModel) {
        comicsImageView.downloadImage(withURL: comic.thumbnail.fullPath)
        comicsTitleLabel.text = comic.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        comicsImageView.image = nil
    }
}
