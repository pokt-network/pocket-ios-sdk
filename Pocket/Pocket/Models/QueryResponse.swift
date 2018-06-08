//
//  QueryResponse.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/5/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftyJSON

public class QueryResponse {
    public var query = Query()
    public var result: Dictionary<AnyHashable, Any>?
    public var decoder: Dictionary<AnyHashable, Any>?
    public var decoded = false
    public var error = false
    public var error_msg = ""
    
    init(json: JSON) {
        guard let responseObject = json.dictionaryObject else {
            return
        }
        
        if responseObject["query"] != nil{
            query = Query.init()
            query.query = responseObject["query"] as! Dictionary<AnyHashable, Any>
        }
        if responseObject["network"] != nil{
            query.network = String(describing: responseObject["network"])
        }
        if responseObject["decoder"] != nil{
            decoder = responseObject["decoder"] as? Dictionary<AnyHashable, Any>
        }
        if responseObject["result"] != nil{
            result = responseObject["result"] as? Dictionary<AnyHashable, Any>
        }
        if responseObject["decoded"] != nil{
            decoded = Bool.init(String(describing: responseObject["decoded"]))!
        }
        if responseObject["error"] != nil{
            error = Bool.init(String(describing: responseObject["error"]))!
        }
        if responseObject["error_msg"] != nil{
            error_msg = String(describing: responseObject["error_msg"])
        }
    }
}
