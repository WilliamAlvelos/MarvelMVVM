//
//  ViewController.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 7/25/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import UIKit

class HeroesViewController: UIViewController {

    //*************************************************
    // MARK: - IBOutlets
    //*************************************************

    @IBOutlet private weak var collectionView: UICollectionView!
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************

    private var viewModel: HeroesViewModel!
    
    //*************************************************
    // MARK: - Inits
    //*************************************************

    init(heroesViewModel: HeroesViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = heroesViewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //*************************************************
    // MARK: - Life Cycle
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel.viewControllerTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.register(UINib(nibName: "HeroCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "HeroCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        
        registesObservables()
        viewModel.loadHeroes()
    }
}

//*************************************************
// MARK: - Private Methods
//*************************************************

extension HeroesViewController {
    private func registesObservables() {
        viewModel.reload = {
            self.collectionView.reloadData()
        }
        
        viewModel.didReceiveError = { error in
            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

//*************************************************
// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
//*************************************************

extension HeroesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = self.viewModel.heroes[indexPath.row]

        let viewModel = HeroDetailViewModel(hero: hero)
        let viewController = HeroDetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        let hero = self.viewModel.heroes[indexPath.row]
        cell.config(with: hero)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if viewModel.shouldLoadNextPage(index: indexPath.row) {
            viewModel.fetchNextPage()
        }
    }
}

//*************************************************
// MARK: - UICollectionViewDelegateFlowLayout
//*************************************************

extension HeroesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 16)/2 - 4, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

