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
        case subnetwork
        case serializedTransaction = "serialized_tx"
        case transactionMetadata = "tx_metadata"
    }
    
    public var error = false
    public var errorMsg = ""
    public var hash = ""
    public var metadata: JSON?
    public var network = ""
    public var subnetwork = ""
    public var serializedTransaction = ""
    public var transactionMetadata: JSON?
    
    public required init(from decodable: Decoder) throws {
        let values = try decodable.container(keyedBy: CodingKeys.self)
        network = try values.decodeIfPresent(String.self, forKey: .network) ?? ""
        subnetwork = try values.decodeIfPresent(String.self, forKey: .subnetwork) ?? ""
        serializedTransaction = try values.decodeIfPresent(String.self, forKey: .serializedTransaction) ?? ""
        transactionMetadata = try values.decodeIfPresent(JSON.self, forKey: .transactionMetadata)
        metadata = try values.decodeIfPresent(JSON.self, forKey: .metadata)
        hash = try values.decodeIfPresent(String.self, forKey: .hash) ?? ""
        error = try values.decodeIfPresent(Bool.self, forKey: .error) ?? false
        errorMsg = try values.decodeIfPresent(String.self, forKey: .errorMsg) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(serializedTransaction, forKey: .serializedTransaction)
        try container.encode(transactionMetadata, forKey: .transactionMetadata)
        try container.encode(hash, forKey: .hash)
        try container.encode(metadata, forKey: .metadata)
        try container.encode(error, forKey: .error)
        try container.encode(errorMsg, forKey: .errorMsg)
        try container.encode(network, forKey: .network)
        try container.encode(subnetwork, forKey: .subnetwork)
    }
    
}

