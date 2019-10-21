//
//  HeroComicsView.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 10/9/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import UIKit

class HeroComicsView: CustomView {
    
    //*************************************************
    // MARK: - IBOutlet
    //*************************************************
    
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var heroComicsCollectionView: UICollectionView!
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************

    var viewModel: HeroComicsViewModel?
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************

    func setup(viewModel: HeroComicsViewModel) {
        self.viewModel = viewModel
        
        self.setupObservable()
        self.setupCollectionView()
        self.setupLayout()
        self.activityIndicator.startAnimating()
        self.viewModel?.request()
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func setupObservable() {
        viewModel?.didReceiveError = { error in
            self.errorView.isHidden = false
            self.errorMessageLabel.text = error.localizedDescription
        }
        
        viewModel?.reload = {
            self.activityIndicator.stopAnimating()
            self.loadingView.isHidden = true
            self.heroComicsCollectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        self.heroComicsCollectionView.delegate = self
        self.heroComicsCollectionView.dataSource = self
        self.heroComicsCollectionView.register(UINib(nibName: "HeroComicsCollectionViewCell", bundle: nil),
                                               forCellWithReuseIdentifier: "HeroComicsCollectionViewCell")

    }
    
    private func setupLayout() {
        self.headerLabel.text = viewModel?.title
    }
}

//*************************************************
// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
//*************************************************

extension HeroComicsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected item \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroComicsCollectionViewCell", for: indexPath) as! HeroComicsCollectionViewCell
        guard let comicModel = viewModel?.comics[indexPath.row] else { return UICollectionViewCell() }
        cell.setup(with: comicModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.comics.count ?? 0
    }
}

//*************************************************
// MARK: - UICollectionViewDelegateFlowLayout
//*************************************************

extension HeroComicsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.width - 16)/2.3 - 4, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

