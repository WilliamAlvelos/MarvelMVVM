//
//  HeroComicsViewModel.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 10/9/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import Foundation

class HeroComicsViewModel {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************

    var reload: (() -> Void)?
    var didReceiveError: ((Error) -> Void)?
    private (set) var comics: [ComicModel] = []
    
    let title: String
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let hero: HeroModel
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(hero: HeroModel, title: String) {
        self.hero = hero
        self.title = title
    }
}

//*************************************************
// MARK: - Public Methods
//*************************************************

extension HeroComicsViewModel {
    func request() {
        ComicService().fetchComic(with: hero) { (result) in
            switch result {
            case .success(let comics):
                self.comics = comics
                self.reload?()
            case .failure(let error):
                self.didReceiveError?(error)
            }
        }
    }
}
