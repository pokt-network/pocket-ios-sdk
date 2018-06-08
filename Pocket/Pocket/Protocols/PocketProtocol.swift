//
//  PocketProtocol.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public typealias PocketInitHandler = (_:PocketProtocol) -> Void

public protocol PocketProtocol: AnyObject {
    static func initPocket(completionHandler: PocketInitHandler)
    func createWallet(passphrase: String) -> Wallet
    func importWallet(walletKey: String, address: String) -> Wallet
    func createTransaction(nonce: String, recipient: String, value: String, data: Dictionary<AnyHashable, Any>) -> Transaction
    func createQuery(data: Dictionary<AnyHashable, Any>, decoder: Dictionary<AnyHashable, Any>) -> Query
}


