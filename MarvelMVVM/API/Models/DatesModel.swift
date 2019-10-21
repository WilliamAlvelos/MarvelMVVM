//
//  DatesModel.swift
//
//  Created by William Alvelos on 10/21/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DatesModel {
    
    // MARK: Properties
    public var type: String?
    public var date: String?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        type = json["type"].string
        date = json["date"].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = type { dictionary["type"] = value }
        if let value = date { dictionary["date"] = value }
        return dictionary
    }
}
