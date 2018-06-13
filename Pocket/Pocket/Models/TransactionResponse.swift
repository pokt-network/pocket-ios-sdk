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
        case network
        case serializedTx = "serialized_tx"
        case txMetadata = "tx_metadata"
        case hash
        case metadata
        case error
        case errorMsg = "error_msg"
    }
    
    public var network = ""
    public var serializedTx = ""
    public var txMetadata: [AnyHashable: Any]?
    public var hash = ""
    public var metadata: [AnyHashable: Any]?
    public var error = false
    public var errorMsg = ""

    public required init(from decodable: Decoder) throws {
        let values = try decodable.container(keyedBy: CodingKeys.self)
        
        network = try values.decodeIfPresent(String.self, forKey: .network) ?? ""
        serializedTx = try values.decodeIfPresent(String.self, forKey: .serializedTx) ?? ""
        
        let stringTxMetadata = try values.decodeIfPresent(String.self, forKey: .txMetadata) ?? ""
        txMetadata = try jsonStringToDictionary(string: stringTxMetadata)
        
        hash = try values.decodeIfPresent(String.self, forKey: .hash) ?? ""
        
        let stringMetadata = try values.decodeIfPresent(String.self, forKey: .metadata) ?? ""
        metadata = try jsonStringToDictionary(string: stringMetadata)
        
        error = try values.decodeIfPresent(Bool.self, forKey: .error) ?? false
        errorMsg = try values.decodeIfPresent(String.self, forKey: .errorMsg) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(serializedTx, forKey: .serializedTx)
            try container.encode(dictionaryToJsonString(dict: txMetadata), forKey: .txMetadata)
            try container.encode(hash, forKey: .hash)
            try container.encode(dictionaryToJsonString(dict: metadata), forKey: .metadata)
            try container.encode(error, forKey: .error)
            try container.encode(errorMsg, forKey: .errorMsg)
        } catch {
            print(error)
        }
    }
    
}
