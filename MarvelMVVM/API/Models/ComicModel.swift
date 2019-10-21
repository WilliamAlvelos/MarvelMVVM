//
//  ComicModel.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 10/9/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import Foundation
import SwiftyJSON

class ComicModel: Parsable {
    
    let id: Int
    let format: String?
    let variantDescription: String?
    let diamondCode: String?
    let modified: String?
    let title: String?
    let issueNumber: Int?
    let descriptionValue: String?
    let pageCount: Int?
    let issn: String?
    let isbn: String?
    let digitalId: Int?
    let resourceURI: String?
    let ean: String?
    let upc: String?
    let thumbnail: ThumbnailModel
    
    var variants: [Any] = []
    var collections: [Any] = []
    var collectedIssues: [Any] = []

    var images: [ThumbnailModel] = []
    var textObjects: [TextObjectsModel] = []
    var prices: [PricesModel] = []
    var dates: [DatesModel] = []
    var urls: [UrlsModel] = []

    let creators: CollectionModel?
    let events: CollectionModel?
    let series: CollectionModel?
    let stories: CollectionModel?
    let characters: CollectionModel?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    required init(_ json: JSON) {
        id = json["id"].int!
        
        format = json["format"].string
        variantDescription = json["variantDescription"].string
        thumbnail = ThumbnailModel(json["thumbnail"])
        diamondCode = json["diamondCode"].string

        modified = json["modified"].string
        title = json["title"].string
        issueNumber = json["issueNumber"].int
        descriptionValue = json["descriptionValue"].string
        pageCount = json["pageCount"].int
        issn = json["issn"].string
        isbn = json["isbn"].string
        digitalId = json["digitalId"].int
        resourceURI = json["resourceURI"].string
        ean = json["ean"].string
        upc = json["upc"].string

        if let items = json["variants"].array { variants = items.map { $0.object} }
        if let items = json["collections"].array { collections = items.map { $0.object} }
        if let items = json["collectedIssues"].array { collectedIssues = items.map { $0.object} }

        if let items = json["images"].array { images = items.map { ThumbnailModel($0) } }
        if let items = json["textObjects"].array { textObjects = items.map { TextObjectsModel(json: $0) } }
        if let items = json["prices"].array { prices = items.map { PricesModel(json: $0) } }
        if let items = json["dates"].array { dates = items.map { DatesModel(json: $0) } }
        if let items = json["urls"].array { urls = items.map { UrlsModel(json: $0) } }
        
        creators = CollectionModel(json["creators"])
        events = CollectionModel(json["events"])
        series = CollectionModel(json["series"])
        stories = CollectionModel(json["stories"])
        characters = CollectionModel(json["characters"])
        
        super.init(json)
    }
}
