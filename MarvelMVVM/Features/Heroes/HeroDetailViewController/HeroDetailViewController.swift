//
//  HeroDetailViewController.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 10/4/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    //*************************************************
    // MARK: - IBOutlets
    //*************************************************
    
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var heroName: UILabel!
    @IBOutlet private weak var heroDescription: UILabel!
    @IBOutlet private weak var heroComicsContainerView: UIView!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************

    var viewModel: HeroDetailViewModel!
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private var heroComicsViewController: HeroComicsViewController?
        
    //*************************************************
    // MARK: - Inits
    //*************************************************

    init(viewModel: HeroDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //*************************************************
    // MARK: - Life Cycle
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel.hero.name
        
        setupData()
    }
    
    private func setupData() {
        self.heroImageView.downloadImage(withURL: viewModel.hero.thumbnail.fullPath)
        self.heroName.text = viewModel.hero.name
        self.heroDescription.text = viewModel.hero.description
        
        setupHeroComicsViewController()
    }
}

//*************************************************
// MARK: - Private Methods
//*************************************************

extension HeroDetailViewController {
    private func setupHeroComicsViewController() {
        let heroComicsViewModel = HeroComicsViewModel(hero: viewModel.hero, title: "Comics")
        let heroComicsViewController = HeroComicsViewController(viewModel: heroComicsViewModel)
        add(heroComicsViewController)
        heroComicsContainerView.addSubview(heroComicsViewController.view)
        heroComicsViewController.view.pinEdges(to: heroComicsContainerView)
        self.heroComicsViewController = heroComicsViewController
    }
}
