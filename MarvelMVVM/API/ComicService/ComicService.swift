//
//  ComicService.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 10/9/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import Foundation

import SwiftyJSON
import Alamofire

protocol ComicServiceProtocol: class {
    func fetchComic(with hero: HeroModel, completion: @escaping(Result<[ComicModel]>) -> Void)
}

class ComicService: ComicServiceProtocol {
    
    let marvelService = MarvelServiceNetwork(environment: .prod)
    
    func fetchComic(with hero: HeroModel, completion: @escaping(Result<[ComicModel]>) -> Void) {
        
        marvelService.request(url: "v1/public/characters/\(hero.id)/comics", completion: { (response: Result<Data>) in
            switch response {
            case .success(let data):
                do {
                    let baseComicModel = try BaseModel<ComicModel>(JSON(data: data))
                    completion(Result.success(baseComicModel.data.results))
                } catch {
                    completion(Result.failure(error))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }
}
