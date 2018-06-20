//
//  Wallet.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

public struct Wallet {
    public var address = ""
    public var privateKey = ""
    public var network = ""
    public var data:[AnyHashable : Any]? = [AnyHashable : Any]()

    public init(jsonString: String) {
        var dict = [AnyHashable: Any]()
        
        do {
            dict = try jsonStringToDictionary(string: jsonString) ?? [AnyHashable: Any]()
        } catch {
            print("Failed to convert jsonString to AnyHashable:Any")
        }
        
        address = dict["address"] as? String ?? ""
        privateKey = dict["privateKey"] as? String ?? ""
        network = dict["network"] as? String ?? ""
        
        do {
            try data = jsonStringToDictionary(string: dict["data"] as? String ?? "")
        } catch {
            print("Failed to convert JSON data to Anyhashable:Any")
        }
    }
    
    public init(address: String, privateKey: String, network: String, data: [AnyHashable : Any]?) {
        self.address = address
        self.privateKey = privateKey
        self.network = network
        self.data = data
    }
    
    public func save() -> Bool {
        let walletString = toJSONString()
        let addressWithNetwork = network+address
        let saveStatus: Bool = KeychainWrapper.standard.set(walletString, forKey: addressWithNetwork)
        
        return saveStatus
    }
    
    public func delete() -> Bool {
        let removeStatus: Bool = KeychainWrapper.standard.removeObject(forKey: address)

        return removeStatus
    }
    
    private func toJSONString() -> String {
        var object = [AnyHashable: Any]()
        var jsonString = ""
        
        object["address"] = address
        object["privateKey"] = privateKey
        object["network"] = network
        
        do {
            object["data"] = try dictionaryToJsonString(dict: data)

        } catch  {
            print("Failed to convert Anyhashable:Any to JSON String")
        }
        
        do {
            jsonString = try dictionaryToJsonString(dict: object) ?? ""
            
        } catch  {
            print("Failed to convert JSON String to Anyhashable:Any")
        }
        
        return jsonString
    }
}
