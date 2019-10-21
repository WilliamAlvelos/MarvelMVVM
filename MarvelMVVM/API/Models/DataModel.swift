//
//  Data.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 2/8/18.
//  Copyright © 2018 William Alvelos. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataModel<T: Parsable> {

	let offset: Int
	let limit: Int
	let total: Int
	let count: Int
	let results: [T]

    init(_ json: JSON) {
		offset = json["offset"].intValue
		limit = json["limit"].intValue
		total = json["total"].intValue
		count = json["count"].intValue
		results = json["results"].arrayValue.map { T($0) }
	}
}
