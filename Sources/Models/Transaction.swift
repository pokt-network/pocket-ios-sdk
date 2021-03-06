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
        case subnetwork
        case serializedTransaction = "serialized_tx"
        case transactionMetadata = "tx_metadata"
    }
    
    public var network = ""
    public var subnetwork = ""
    public var serializedTransaction = ""
    public var transactionMetadata: JSON?
    
    public init(network: String, subnetwork: String, serializedTransaction: String, transactionMetadata: JSON?) {
        self.network = network
        self.subnetwork = subnetwork
        self.serializedTransaction = serializedTransaction
        self.transactionMetadata = transactionMetadata
    }
    
    public init(obj: [AnyHashable: Any]!) {
        network = obj["network"] as? String ?? ""
        subnetwork = obj["subnetwork"] as? String ?? ""
        serializedTransaction = obj["serialized_tx"] as? String ?? ""
        transactionMetadata = obj["tx_metadata"] as? JSON ?? JSON.object([String : JSON]())
    }
    
    public required init(from decodable: Decoder) throws {
        let values = try decodable.container(keyedBy: CodingKeys.self)
        
        network = try values.decodeIfPresent(String.self, forKey: .network) ?? ""
        subnetwork = try values.decodeIfPresent(String.self, forKey: .subnetwork) ?? ""
        serializedTransaction = try values.decodeIfPresent(String.self, forKey: .serializedTransaction) ?? ""
        transactionMetadata = try values.decodeIfPresent(JSON.self, forKey: .transactionMetadata)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(serializedTransaction, forKey: .serializedTransaction)
        try container.encode(transactionMetadata, forKey: .transactionMetadata)
        try container.encode(network, forKey: .network)
        try container.encode(subnetwork, forKey: .subnetwork)
    }
}
