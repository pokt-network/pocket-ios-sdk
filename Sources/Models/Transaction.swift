//
//  Transaction.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public class Transaction: Codable {
    
    enum CodingKeys: String, CodingKey {
        case network
        case serializedTransaction = "serialized_tx"
        case tranactionMetadata = "tx_metadata"
    }
    
    public var network = ""
    public var serializedTransaction = ""
    public var transactionMetadata: JSON?
    
    public init(obj: [AnyHashable: Any]!){
        network = obj["network"] as? String ?? ""
        serializedTransaction = obj["serialized_tx"] as? String ?? ""
        transactionMetadata = obj["tx_metadata"] as? JSON ?? JSON.object([String : JSON]())
    }
    
    public required init(from decodable: Decoder) throws {
        let values = try decodable.container(keyedBy: CodingKeys.self)
        
        network = try values.decodeIfPresent(String.self, forKey: .network) ?? ""
        serializedTransaction = try values.decodeIfPresent(String.self, forKey: .serializedTransaction) ?? ""
        transactionMetadata = try values.decodeIfPresent(JSON.self, forKey: .tranactionMetadata)
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(serializedTransaction, forKey: .serializedTransaction)
            try container.encode(transactionMetadata, forKey: .tranactionMetadata)
            try container.encode(network, forKey: .network)
        } catch {
            print(error)
        }
    }
}
