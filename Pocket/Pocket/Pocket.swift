//
//  Pocket.swift
//  Pocket
//
//  Created by Luis De Leon on 6/5/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public typealias SubmitTransactionHandler = (_:TransactionResponse) -> Void
public typealias ExecuteQueryHandler = (_:QueryResponse) -> Void

class Pocket {
    
    static var pocketInstance:Pocket?
    var pocketNodeURL:URL?
    
    class func getInstance(pocketNodeURL: URL) -> Pocket {
        if(pocketInstance == nil) {
            pocketInstance = Pocket(pocketNodeURL: pocketNodeURL)
        }
        return pocketInstance!
    }
    
    init(pocketNodeURL: URL){
        self.pocketNodeURL = pocketNodeURL
    }
    
    func sendTransaction(tx: Transaction, handler: SubmitTransactionHandler) {
        // 1.- Send transaction to the pocket node
        // 2.- Create transactionresponse object with response data
        // 3.- Call handler with transactionresponse
    }
    
    func executeQuery(query: Query, handler: ExecuteQueryHandler) {
        // 1.- Send query to the pocket node
        // 2.- Create queryresponse object with response data
        // 3.- Call handler with queryresponse
    }
}
