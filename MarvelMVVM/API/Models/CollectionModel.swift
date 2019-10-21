//
//  CollectionModel.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 2/8/18.
//  Copyright © 2018 William Alvelos. All rights reserved.
//

import Foundation
import SwiftyJSON

class CollectionModel {

	let available: Int
	let collectionURI: String
	let items: [ItemsModel]
	let returned: Int

	init(_ json: JSON) {
		available = json["available"].intValue
		collectionURI = json["collectionURI"].stringValue
		items = json["items"].arrayValue.map { ItemsModel($0) }
		returned = json["returned"].intValue
	}
}
