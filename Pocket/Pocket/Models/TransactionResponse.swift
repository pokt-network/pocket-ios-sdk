//
//  TransactionResponse.swift
//  Pocket
//
//  Created by Luis De Leon on 6/5/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public class TransactionResponse: Codable {
    
    enum CodingKeys : String, CodingKey {
        case error
        case errorMsg = "error_msg"
        case hash
        case metadata
        case network
        case serializedTransaction = "serialized_tx"
        case transactionMetadata = "tx_metadata"
    }

    public var error = false
    public var errorMsg = ""
    public var hash = ""
    public var metadata: [AnyHashable: Any]?
    public var network = ""
    public var serializedTransaction = ""
    public var transactionMetadata: [AnyHashable: Any]?

    public required init(from decodable: Decoder) throws {
        let values = try decodable.container(keyedBy: CodingKeys.self)
        
        network = try values.decodeIfPresent(String.self, forKey: .network) ?? ""
        serializedTransaction = try values.decodeIfPresent(String.self, forKey: .serializedTransaction) ?? ""
        
        let stringTxMetadata = try values.decodeIfPresent(String.self, forKey: .transactionMetadata) ?? ""
        transactionMetadata = try Utility.jsonStringToDictionary(string: stringTxMetadata)
        
        hash = try values.decodeIfPresent(String.self, forKey: .hash) ?? ""
        
        let stringMetadata = try values.decodeIfPresent(String.self, forKey: .metadata) ?? ""
        metadata = try Utility.jsonStringToDictionary(string: stringMetadata)
        
        error = try values.decodeIfPresent(Bool.self, forKey: .error) ?? false
        errorMsg = try values.decodeIfPresent(String.self, forKey: .errorMsg) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(serializedTransaction, forKey: .serializedTransaction)
            try container.encode(Utility.dictionaryToJsonString(dict: transactionMetadata), forKey: .transactionMetadata)
            try container.encode(hash, forKey: .hash)
            try container.encode(Utility.dictionaryToJsonString(dict: metadata), forKey: .metadata)
            try container.encode(error, forKey: .error)
            try container.encode(errorMsg, forKey: .errorMsg)
        } catch {
            print(error)
        }
    }
    
}
