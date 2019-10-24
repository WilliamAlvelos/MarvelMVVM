//
//  HeroesViewModel.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 8/12/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import Foundation

class HeroesViewModel {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var reload: (() -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    
    var heroes: [HeroModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reload?()
            }
        }
    }
    
    var viewControllerTitle: String {
        return "Heroes"
    }
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************

    private var characterService: CharacterServiceProtocol!
    private var filter: FilterModel = FilterModel(orderBy: .name, name: nil, nameStartsWith: nil, limit: 20, offset: 0)
    private var pageNumber: Int = 0
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(characterService: CharacterServiceProtocol) {
        self.characterService = characterService
    }
}

//*************************************************
// MARK: - Public Methods
//*************************************************

extension HeroesViewModel {
    /// This method fetch heroes using a filter
    func loadHeroes() {
        self.filter.offset = self.pageNumber * (self.filter.limit ?? 20)
        self.characterService.fetchCharacters(with: filter) { result in
            switch result {
            case .success(let heros):
                self.heroes += heros
            case .failure(let error):
                self.didReceiveError?(error)
            }
        }
    }
    
    /// This method sets filter off set to zero.
    func resetPagination() {
        self.filter.offset = 0
    }
     
    /// This method fetch the next heroes page when it's called.
    func fetchNextPage() {
        pageNumber += 1
        loadHeroes()
    }
    
    func shouldLoadNextPage(index: Int) -> Bool {
        return index == heroes.count - 1
    }
}
