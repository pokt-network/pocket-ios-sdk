//
//  QueryResponse.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/5/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public class QueryResponse: Codable {

    enum CodingKeys : String, CodingKey {
        case network
        case data = "query"
        case result
        case decoder
        case decoded
        case error
        case errorMsg = "error_msg"
    }

    // Request
    public var network = ""
    public var data: JSON?
    public var decoder: JSON?
    // Response
    public var result: JSON?
    public var decoded = false
    public var error = false
    public var errorMsg = ""

    public required init(from decodable: Decoder) throws {
        let values = try decodable.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(JSON.self, forKey: .result)
        data = try values.decodeIfPresent(JSON.self, forKey: .data)
        decoder = try values.decodeIfPresent(JSON.self, forKey: .decoder)
        decoded = try values.decodeIfPresent(Bool.self, forKey: .decoded) ?? false
        error = try values.decodeIfPresent(Bool.self, forKey: .error) ?? false
        errorMsg = try values.decodeIfPresent(String.self, forKey: .errorMsg) ?? ""
        network = try values.decodeIfPresent(String.self, forKey: .network) ?? ""
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(decoder, forKey: .decoder)
        try container.encodeIfPresent(data, forKey: .data)
        try container.encodeIfPresent(decoded, forKey: .decoded)
        try container.encodeIfPresent(error, forKey: .error)
        try container.encodeIfPresent(errorMsg, forKey: .errorMsg)
        try container.encodeIfPresent(network, forKey: .network)
    }

}
