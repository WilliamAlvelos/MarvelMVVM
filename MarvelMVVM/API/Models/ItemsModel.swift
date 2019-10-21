//
//  ItemsModel.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 2/8/18.
//  Copyright © 2018 William Alvelos. All rights reserved.
//

import Foundation
import SwiftyJSON

class ItemsModel {

	let resourceURI: String
	let name: String

	init(_ json: JSON) {
		resourceURI = json["resourceURI"].stringValue
		name = json["name"].stringValue
	}
}
