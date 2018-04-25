//
//  Transaction.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

class Transaction {
    
    var nonce: String
    var recipient: String
    var value: String
    var data: NSDictionary
    var signed: String
    
    init(nonce: String, recipient: String, value: String, data: NSDictionary) {
        self.nonce = nonce
        self.recipient = recipient
        self.value = value
        self.data = data
        self.signed = ""
    }
    
    func signTransaction(transaction: Transaction) {
        // Sign transaction
        let signedTransaction = ""
        self.signed = signedTransaction
    }
}
