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
     
     Example:
     
     let transaction = Transaction(nonce: "noncenumber", recipient: "recipient'saddress", value: "0.0", data: [key:value], signed: nil)
     
     let signedTransaction = signTransaction(transaction: transaction)
     
     Signs a transaction
     
     - **Returns**:
     
        A Signed transaction type object
     
     - **Parameters**:
     
        - transaction: Unsigned Transaction type object. Can not be empty.
     
     - **Important**:
     
        Draft method.
     
     - **Version**:
     
        0.1
     
     */
    
    public mutating func signTransaction(transaction: Transaction) {
        // Sign transaction
        let signedTransaction = ""
        self.signed = signedTransaction
    }

}
