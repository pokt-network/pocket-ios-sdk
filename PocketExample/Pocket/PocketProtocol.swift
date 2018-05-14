//
//  PocketProtocol.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public protocol Pocket {
    func createWallet(passphrase: String) -> Wallet
    func importWallet(walletKey: String, address: String) -> Wallet
    func createTransaction(nonce: String, recipient: String, value: String, data: Dictionary<AnyHashable, Any>) -> Transaction
    func signTransaction(transaction: Transaction) -> Transaction
    func sendTransaction(signedTransaction: Transaction)
}
