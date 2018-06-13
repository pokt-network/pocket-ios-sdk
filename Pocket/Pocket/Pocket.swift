//
//  Pocket.swift
//  Pocket
//
//  Created by Luis De Leon on 6/5/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

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
        requestManager!.sendRequest(request: tx as! Encoder) { (json, error) in
            var response: TransactionResponse?
            
            if json != nil {
                // Init transaction response with codable
//                do {
//                    response = try TransactionResponse.init(from: json)
//                }
//                catch {
//                    throw print(error)
//                }
            }
    
            handler(response, error)
        }
    }
    
    func executeQuery(query: [AnyHashable: Any], handler: @escaping ExecuteQueryHandler) {
        requestManager!.sendRequest(request: query as! Encoder) { (json, error) in
            var response: QueryResponse?
            
            if json != nil {
                //Query.init(from: json)
                // Init query response with codable
//                do {
//                    response = try QueryResponse(from: json)
//                }
//                catch {
//                    throw print(error)
//                }
            }
            
            handler(response, error)
        }
    }
}
