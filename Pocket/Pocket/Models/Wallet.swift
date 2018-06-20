//
//  Wallet.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

public enum WalletPersistenceError: Error {
    case invalidWallet
    case walletSerializationError
}

public struct Wallet {
    public var address = ""
    public var privateKey = ""
    public var network = ""
    public var data:[AnyHashable : Any]? = [AnyHashable : Any]()

    //Public interface
    public init(jsonString: String) throws {
        var dict = try jsonStringToDictionary(string: jsonString) ?? [AnyHashable: Any]()
        address = dict["address"] as? String ?? ""
        privateKey = dict["privateKey"] as? String ?? ""
        network = dict["network"] as? String ?? ""
        data = try jsonStringToDictionary(string: dict["data"] as? String ?? "")
    }
    
    public init(address: String, privateKey: String, network: String, data: [AnyHashable : Any]?) {
        self.address = address
        self.privateKey = privateKey
        self.network = network
        self.data = data
    }
    
    // Persistence public interface
    public func save() throws -> Bool {
        if isValid() {
            return  KeychainWrapper.standard.set(try toJSONString(), forKey: recordKey())
        } else {
            throw WalletPersistenceError.invalidWallet
        }
    }
    
    public func delete() throws -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: recordKey())
    }
    
    public static func retrieveWallets() throws -> [Wallet] {
        var wallets = [Wallet]()
        let allRecords = KeychainWrapper.standard.allKeys()
        
        for record in allRecords {
            let wallet = try Wallet(jsonString: record)
            wallets.append(wallet)
        }
        
        return wallets
    }
    
    public static func retrieveWallet(network: String, address: String) throws -> Wallet{
        let walletJSONString: String? = KeychainWrapper.standard.string(forKey: Wallet.recordKey(network: network, address: address))
        let wallet = try Wallet(jsonString: walletJSONString ?? "")
        return wallet
    }
    
    // Private functions
    private func isValid() -> Bool {
        return !network.isEmpty && !address.isEmpty && !privateKey.isEmpty
    }
    
    private func recordKey() -> String {
        return Wallet.recordKey(network: network, address: address)
    }
    
    private static func recordKey(network: String, address: String) -> String {
        return network + "/" + address
    }
    
    private func toJSONString() throws -> String {
        var object = [AnyHashable: Any]()
        object["address"] = address
        object["privateKey"] = privateKey
        object["network"] = network
        object["data"] = try dictionaryToJsonString(dict: data)
        guard let result = try dictionaryToJsonString(dict: object) else {
            throw WalletPersistenceError.walletSerializationError
        }
        
        return result
    }
}
