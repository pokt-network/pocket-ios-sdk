//
//  Query.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/5/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Query: PocketRequestProtocol {
    public var network = ""
    public var query = Dictionary<AnyHashable, Any>()
    public var decoder = Dictionary<AnyHashable, Any>()
    
    public func toJSON() -> JSON {
        return JSON.init(self)
    }
}
