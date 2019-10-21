//
//  ThumbnailModel.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 2/8/18.
//  Copyright © 2018 William Alvelos. All rights reserved.
//

import Foundation
import SwiftyJSON

class ThumbnailModel {

	let path: String
	let extensionField: String

	init(_ json: JSON) {
		path = json["path"].stringValue
		extensionField = json["extension"].stringValue
	}
}


extension ThumbnailModel {
    var fullPath: String {
        return self.path + "." + self.extensionField
    }
}
