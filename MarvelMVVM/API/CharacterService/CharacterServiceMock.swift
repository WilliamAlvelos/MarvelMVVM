//
//  CharacterServiceMock.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 7/26/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CharacterServiceMock: CharacterServiceProtocol {
    
    func fetchCharacters(with filter: FilterModel, completion: @escaping(Result<[HeroModel]>) -> Void) {
        if let path = Bundle.main.path(forResource: "characters", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let baseHerosModel = try BaseModel<HeroModel>(JSON(data: data))
                completion(Result.success(baseHerosModel.data.results))
            } catch {
                completion(Result.failure(error))
            }
        }
    }
    
    func fetchCharacterDetails(withCharacterId characterId: Int, and filter: FilterModel, completion: @escaping(Result<HeroModel>) -> Void) {
        if let path = Bundle.main.path(forResource: "characters", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let baseHerosModel = try BaseModel<HeroModel>(JSON(data: data))
                completion(Result.success(baseHerosModel.data.results.first!))
            } catch {
                completion(Result.failure(error))
            }
        }
    }
}
