//
//  PocketProtocol.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public protocol PocketPlugin {
    static func createWallet(passphrase: String) -> Wallet
    static func importWallet(privateKey: String, publicKey: String, data: [AnyHashable: Any]) -> Wallet
    static func createTransaction(wallet: Wallet, data: [AnyHashable: Any]) -> Transaction
    static func createQuery(data: [AnyHashable: Any], decoder: [AnyHashable: Any]?) -> Query
}

