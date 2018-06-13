//
//  Transaction.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public class Transaction: Codable {
    
    enum CodingKeys : String, CodingKey {
        case network
        case serializedTx = "serialized_tx"
        case txMetadata = "tx_metadata"
    }
    
    public var network = ""
    public var serializedTx = ""
    public var txMetadata: [AnyHashable: Any]?
    
    public init() {
        
    }
    
    public required init(from decodable: Decoder) throws {
        let values = try decodable.container(keyedBy: CodingKeys.self)
        
        network = try values.decodeIfPresent(String.self, forKey: .network) ?? ""
        serializedTx = try values.decodeIfPresent(String.self, forKey: .serializedTx) ?? ""
        
        let stringTxMetadata = try values.decodeIfPresent(String.self, forKey: .txMetadata) ?? ""
        txMetadata = try jsonStringToDictionary(string: stringTxMetadata)
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(serializedTx, forKey: .serializedTx)
            try container.encode(dictionaryToJsonString(dict: txMetadata), forKey: .txMetadata)
        } catch {
            print(error)
        }
    }
}
