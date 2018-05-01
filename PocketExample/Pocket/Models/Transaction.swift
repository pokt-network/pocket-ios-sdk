//
//  Transaction.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

struct Transaction {
    
    var nonce = ""
    var recipient = ""
    var value = ""
    var data = [AnyHashable: Any]()
    var signed = ""
    
    mutating func signTransaction(transaction: Transaction) {
        // Sign transaction
        let signedTransaction = ""
        self.signed = signedTransaction
    }
}
