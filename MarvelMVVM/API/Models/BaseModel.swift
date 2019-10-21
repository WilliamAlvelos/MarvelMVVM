//
//  BaseModel.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 2/8/18.
//  Copyright © 2018 William Alvelos. All rights reserved.
//

import Foundation
import SwiftyJSON

class BaseModel<T: Parsable> {
	let code: Int
	let status: String
	let copyright: String
	let attributionText: String
	let attributionHTML: String
	let etag: String
    let data: DataModel<T>

    init(_ json: JSON) {
		code = json["code"].intValue
		status = json["status"].stringValue
		copyright = json["copyright"].stringValue
		attributionText = json["attributionText"].stringValue
		attributionHTML = json["attributionHTML"].stringValue
		etag = json["etag"].stringValue
		data = DataModel(json["data"])
	}
}
