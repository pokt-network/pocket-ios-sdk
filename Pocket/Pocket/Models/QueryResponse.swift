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
    public var data: [AnyHashable: Any]?
    public var decoder: [AnyHashable: Any]?
    // Response
    public var result: [AnyHashable: Any]?
    public var decoded = false
    public var error = false
    public var errorMsg = ""
    
    public required init(from decodable: Decoder) throws {
        let values = try decodable.container(keyedBy: CodingKeys.self)
        
        let stringData = try values.decodeIfPresent(String.self, forKey: .data) ?? ""
        result = try jsonStringToDictionary(string: stringData)
        
        let stringResult = try values.decodeIfPresent(String.self, forKey: .result) ?? ""
        result = try jsonStringToDictionary(string: stringResult)
        
        let stringDecoder = try values.decodeIfPresent(String.self, forKey: .decoder) ?? ""
        decoder = try jsonStringToDictionary(string: stringDecoder)
        
        decoded = try values.decodeIfPresent(Bool.self, forKey: .decoded) ?? false
        error = try values.decodeIfPresent(Bool.self, forKey: .error) ?? false
        errorMsg = try values.decodeIfPresent(String.self, forKey: .errorMsg) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(dictionaryToJsonString(dict: data), forKey: .data)
            try container.encode(dictionaryToJsonString(dict: result), forKey: .result)
            try container.encode(dictionaryToJsonString(dict: decoder), forKey: .decoder)
            try container.encode(decoded, forKey: .decoded)
            try container.encode(error, forKey: .error)
            try container.encode(errorMsg, forKey: .errorMsg)
        } catch {
            print(error)
        }
    }

}
