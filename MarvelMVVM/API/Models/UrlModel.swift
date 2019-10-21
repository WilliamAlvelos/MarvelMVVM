//
//  UrlModel.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 2/8/18.
//  Copyright © 2018 William Alvelos. All rights reserved.
//

import Foundation
import SwiftyJSON

class UrlModel {

	let type: String
	let url: String

	init(_ json: JSON) {
		type = json["type"].stringValue
		url = json["url"].stringValue
	}
}
