//
//  Pocket.swift
//  Pocket
//
//  Created by Luis De Leon on 6/5/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftyJSON

public typealias TransactionHandler = (_: TransactionResponse?, _: Error?) -> Void
public typealias ExecuteQueryHandler = (_: QueryResponse?, _:Error?) -> Void

class Pocket {
    var requestManager:PocketRequestManager?
    static var pocketInstance:Pocket?
    var pocketNodeURL:URL?
    
    class func getInstance(pocketNodeURL: URL) -> Pocket {
        if(pocketInstance == nil) {
            let configuration = URLSessionConfiguration.ephemeral
            let requestManager = PocketRequestManager.init(configuration: configuration, url: pocketNodeURL)
            pocketInstance = Pocket(pocketNodeURL: pocketNodeURL, requestManager: requestManager)
        }
        return pocketInstance!
    }
    
    init(pocketNodeURL: URL, requestManager: PocketRequestManager){
        self.pocketNodeURL = pocketNodeURL
        self.requestManager = requestManager
    }
    
    func sendTransaction(tx: Transaction, handler: @escaping TransactionHandler) {
        requestManager!.sendRequest(request: tx) { (json, error) in
            var response: TransactionResponse?
            
            if json != JSON.null {
                response = TransactionResponse.init(json: json)
            }
    
            handler(response, error)
        }
    }
    
    func executeQuery(query: Query, handler: @escaping ExecuteQueryHandler) {
        requestManager!.sendRequest(request: query) { (json, error) in
            var response: QueryResponse?
            
            if json != JSON.null {
                response = QueryResponse.init(json: json)
            }
            
            handler(response, error)
        }
    }
}
