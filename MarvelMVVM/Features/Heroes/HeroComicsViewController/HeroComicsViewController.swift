//
//  HeroComicsViewController.swift
//  MarvelMVVM
//
//  Created by AndreLO on 24/10/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import UIKit

class HeroComicsViewController: UIViewController {

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

    let viewModel: HeroComicsViewModel
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(viewModel: HeroComicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservable()
        setupCollectionView()
        setupLayout()
        requestComics()
    }
}

//*************************************************
// MARK: - Private Methods
//*************************************************

extension HeroComicsViewController {
    private func requestComics() {
        activityIndicator.startAnimating()
        viewModel.request()
    }
    
    private func setupObservable() {
        viewModel.didReceiveError = { error in
            self.errorView.isHidden = false
            self.errorMessageLabel.text = error.localizedDescription
        }
        
        viewModel.reload = {
            self.activityIndicator.stopAnimating()
            self.loadingView.isHidden = true
            self.heroComicsCollectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        self.heroComicsCollectionView.delegate = self
        self.heroComicsCollectionView.dataSource = self
        self.heroComicsCollectionView.register(HeroComicsCollectionViewCell.nib, forCellWithReuseIdentifier: HeroComicsCollectionViewCell.identifier)
    }
    
    private func setupLayout() {
        self.headerLabel.text = viewModel.title
    }
}

//*************************************************
// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
//*************************************************

extension HeroComicsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected item \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroComicsCollectionViewCell.identifier, for: indexPath) as! HeroComicsCollectionViewCell
        let comicModel = viewModel.comics[indexPath.row]
        cell.setup(with: comicModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.comics.count
    }
}

//*************************************************
// MARK: - UICollectionViewDelegateFlowLayout
//*************************************************

extension HeroComicsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 16)/2.3 - 4, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
