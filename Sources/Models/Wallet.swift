//
//  Wallet.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import RNCryptor

public enum WalletPersistenceError: Error {
    case invalidWallet
    case walletSerializationError
}

public struct Wallet {
    public var address = ""
    public var privateKey = ""
    public var network = ""
    public var subnetwork = ""
    public var data: [AnyHashable: Any]? = [AnyHashable: Any]()

    public init(jsonString: String) throws {
        var dict = try Utility.jsonStringToDictionary(string: jsonString) ?? [AnyHashable: Any]()
        address = dict["address"] as? String ?? ""
        privateKey = dict["privateKey"] as? String ?? ""
        network = dict["network"] as? String ?? ""
        subnetwork = dict["subnetwork"] as? String ?? ""
        data = try Utility.jsonStringToDictionary(string: dict["data"] as? String ?? "")
    }
    
    public init(address: String, privateKey: String, network: String, subnetwork: String, data: [AnyHashable : Any]?) {
        self.address = address
        self.privateKey = privateKey
        self.network = network
        self.subnetwork = subnetwork
        self.data = data
    }
    
    // Persistence public interface
    public func save(passphrase: String) throws -> Bool {
        if isValid() {
            guard let jsonData = try toJSONString().data(using: .utf8) else {
                throw WalletPersistenceError.invalidWallet
            }
            let ciphertext = RNCryptor.encrypt(data: jsonData, withPassword: passphrase)
            return  Wallet.getKeychainWrapper().set(ciphertext, forKey: recordKey())
        } else {
            throw WalletPersistenceError.invalidWallet
        }
    }
    
    public func delete() throws -> Bool {
        return Wallet.getKeychainWrapper().removeObject(forKey: recordKey())
    }
    
    public static func retrieveWalletRecordKeys() -> [String] {
        return Array(Wallet.getKeychainWrapper().allKeys())
    }
    
    public static func retrieveWallet(network: String, subnetwork: String, address: String, passphrase: String) throws -> Wallet {
        guard let encryptedWalletData = Wallet.getKeychainWrapper().data(forKey: Wallet.recordKey(network: network, subnetwork: subnetwork, address: address)) else {
            throw WalletPersistenceError.walletSerializationError
        }
        guard let decryptedWalletJSON = String.init(data: try RNCryptor.decrypt(data: encryptedWalletData, withPassword: passphrase), encoding: .utf8) else {
            throw WalletPersistenceError.walletSerializationError
        }
        let wallet = try Wallet(jsonString: decryptedWalletJSON)
        return wallet
    }
    
    private static func getKeychainWrapper() -> KeychainWrapper {
        return KeychainWrapper.standard
    }
    
    // Private functions
    private func isValid() -> Bool {
        return !network.isEmpty && !address.isEmpty && !privateKey.isEmpty
    }
    
    private func recordKey() -> String {
        return Wallet.recordKey(network: network, subnetwork: subnetwork, address: address)
    }
    
    private static func recordKey(network: String, subnetwork: String, address: String) -> String {
        return network + "/" + subnetwork + "/" + address
    }
    
    private func toJSONString() throws -> String {
        var object = [AnyHashable: Any]()
        object["address"] = address
        object["privateKey"] = privateKey
        object["network"] = network
        object["subnetwork"] = subnetwork
        object["data"] = try Utility.dictionaryToJsonString(dict: data)
        guard let result = try Utility.dictionaryToJsonString(dict: object) else {
            throw WalletPersistenceError.walletSerializationError
        }
        return result
    }
}
