//
//  CharacterService.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 7/25/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol CharacterServiceProtocol: class {
    func fetchCharacters(with filter: FilterModel, completion: @escaping(Result<[HeroModel]>) -> Void)
    func fetchCharacterDetails(withCharacterId characterId: Int, and filter: FilterModel, completion: @escaping(Result<HeroModel>) -> Void)
}

class CharacterService: CharacterServiceProtocol {
    
    let marvelService = MarvelServiceNetwork(environment: .prod)
    
    func fetchCharacters(with filter: FilterModel, completion: @escaping(Result<[HeroModel]>) -> Void) {
        
        marvelService.request(url: "v1/public/characters", parameters: filter.dictionary, completion: { (response: Result<Data>) in
            switch response {
            case .success(let data):
                do {
                    let baseHerosModel = try BaseModel<HeroModel>(JSON(data: data))
                    completion(Result.success(baseHerosModel.data.results))
                } catch {
                    completion(Result.failure(error))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }
    
    func fetchCharacterDetails(withCharacterId characterId: Int, and filter: FilterModel, completion: @escaping(Result<HeroModel>) -> Void) {
        marvelService.request(url: "v1/public/characters/\(characterId)") { (response: Result<Data>) in
            switch response {
            case .success(let data):
                do {
                    let baseHerosModel = try BaseModel<HeroModel>(JSON(data: data))
                    completion(Result.success(baseHerosModel.data.results.first!))
                } catch {
                    completion(Result.failure(error))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
