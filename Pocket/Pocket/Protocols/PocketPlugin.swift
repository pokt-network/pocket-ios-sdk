//
//  PocketPlugin.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public enum PocketPluginError: Error {
    case transactionCreationError(String)
    case queryCreationError(String)
    case walletCreationError(String)
    case walletImportError(String)
}

public protocol PocketPlugin {
    static func createWallet(data: [AnyHashable : Any]?) throws -> Wallet
    static func importWallet(privateKey: String, address: String?, data: [AnyHashable : Any]?) throws -> Wallet
    static func createTransaction(wallet: Wallet, params: [AnyHashable : Any]) throws -> Transaction
    static func createQuery(params: [AnyHashable : Any], decoder: [AnyHashable : Any]?) throws -> Query
}

