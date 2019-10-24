//
//  HeroComicsCollectionViewModel.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 10/9/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import Foundation

class HeroComicsCollectionViewModel {
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let comics: ComicModel
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var thumbnail: String {
        return comics.thumbnail.fullPath
    }
    
    var title: String {
        return comics.title ?? "Título Desconhecido"
    }
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(comics: ComicModel) {
        self.comics = comics
    }
}
