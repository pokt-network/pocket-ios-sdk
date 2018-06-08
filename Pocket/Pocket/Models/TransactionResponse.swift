//
//  TransactionResponse.swift
//  Pocket
//
//  Created by Luis De Leon on 6/5/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TransactionResponse {
    public var network: Network?
    public var serialized_tx = ""
    public var tx_metadata = Dictionary<AnyHashable, Any>()
    public var hash = ""
    public var metadata = Dictionary<AnyHashable, Any>()
    public var error = false
    public var error_msg = ""
    
    init(json: JSON) {
        
        guard let responseObject = json.dictionaryObject else {
            return
        }
        
        if responseObject["network"] != nil{
            network?.tokenID = String(describing: responseObject["network"])
        }
        if responseObject["serialized_tx"] != nil{
            serialized_tx = String(describing: responseObject["serialized_tx"])
        }
        if responseObject["tx_metadata"] != nil{
            tx_metadata = responseObject["tx_metadata"] as! Dictionary<AnyHashable, Any>
        }
        if responseObject["hash"] != nil{
            hash = String(describing: responseObject["hash"])
        }
        if responseObject["metadata"] != nil{
            metadata = responseObject["metadata"] as! Dictionary<AnyHashable, Any>
        }
        if responseObject["error"] != nil{
            error = Bool.init(String(describing: responseObject["error"]))!
        }
        if responseObject["error_msg"] != nil{
            error_msg = String(describing: responseObject["error_msg"])
        }

    }
}
