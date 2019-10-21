//
//  FilterModel.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 7/29/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import Foundation

enum OrderBy: String {
    case name
    case modified
}

struct FilterModel {
    
    var orderBy: OrderBy = .name
    var name: String?
    var nameStartsWith: String?
    var limit: Int?
    var offset: Int?
}

extension FilterModel {
    var dictionary: [String: Any] {
        return ["orderBy": orderBy.rawValue,
                "name": name ?? NSNull.self,
                "nameStartsWith": nameStartsWith ?? NSNull.self,
                "limit": limit ?? NSNull.self,
                "offset": offset ?? NSNull.self].filter({ !($0.value is NSNull.Type) })
    }
}
