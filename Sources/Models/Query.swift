//
//  Query.swift
//  Pocket
//
//  Created by Luis De Leon on 6/13/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public final class Query: Codable {
    
    enum CodingKeys: String, CodingKey {
        case network
        case subnetwork
        case data = "query"
        case decoder
    }
    
    public var network = ""
    public var subnetwork = ""
    public var data: JSON?
    public var decoder: JSON?
    
    public init() {
        
    }
    
    public required init(from decodable: Decoder) throws {
        let values = try decodable.container(keyedBy: CodingKeys.self)
        network = try values.decodeIfPresent(String.self, forKey: .network) ?? ""
        subnetwork = try values.decodeIfPresent(String.self, forKey: .subnetwork) ?? ""
        decoder = try values.decodeIfPresent(JSON.self, forKey: .decoder)
        data = try values.decodeIfPresent(JSON.self, forKey: .data)
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(network, forKey: .network)
            try container.encode(network, forKey: .subnetwork)
            try container.encode(data, forKey: .data)
            try container.encode(decoder, forKey: .decoder)
        } catch {
            print(error)
        }
    }
}
