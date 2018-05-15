//
//  Transaction.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public struct Transaction {
    public var nonce = ""
    public var recipient = ""
    public var value = ""
    public var data = [AnyHashable: Any]()
    public var signed = ""

    /**
     Signs an unsigned Transaction type object.

     ```
     // Example: Signs a transaction.
     let transaction = Transaction(nonce: "noncenumber", recipient: "recipient'saddress", value: "0.0", data: [key:value], signed: nil)
     let signedTransaction = signTransaction(transaction: transaction)
     ```

     - Parameters:
        - transaction: Unsigned Transaction type object.
     
     - Returns: A Signed transaction type object.
     */
    public mutating func signTransaction(transaction: Transaction) {
        // Sign transaction
        let signedTransaction = ""
        self.signed = signedTransaction
    }

}
