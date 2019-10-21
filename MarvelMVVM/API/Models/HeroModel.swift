//
//  Results.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 2/8/18.
//  Copyright © 2018 William Alvelos. All rights reserved.
//

import Foundation
import SwiftyJSON

class Parsable {
    required init(_ json: JSON) { }
}

class HeroModel: Parsable {
    let id: Int
	let name: String
	let description: String
	let modified: String
	let thumbnail: ThumbnailModel
	let resourceURI: String
	let comics: CollectionModel?
	let series: CollectionModel?
	let stories: CollectionModel?
	let events: CollectionModel?
	let urls: [UrlModel]

    required init(_ json: JSON) {
		id = json["id"].intValue
		name = json["name"].stringValue
		description = json["description"].stringValue
		modified = json["modified"].stringValue
		thumbnail = ThumbnailModel(json["thumbnail"])
		resourceURI = json["resourceURI"].stringValue
		comics = CollectionModel(json["comics"])
		series = CollectionModel(json["series"])
		stories = CollectionModel(json["stories"])
		events = CollectionModel(json["events"])
		urls = json["urls"].arrayValue.map { UrlModel($0) }
        super.init(json)
	}
}


