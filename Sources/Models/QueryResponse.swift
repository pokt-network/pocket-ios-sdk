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
    public var result: Any?
    public var decoded = false
    public var error = false
    public var errorMsg = ""
    
    // Convenience
    public var stringResult: String? {
        get {
            return self.result as? String ?? nil
        }
    }
    public var dictResult: [AnyHashable: Any]? {
        get {
            return self.result as? [AnyHashable: Any] ?? nil
        }
    }
    public var arrResult: [Any]? {
        get {
            return self.result as? [Any] ?? nil
        }
    }
    
    public required init(from decodable: Decoder) throws {
        let values = try decodable.container(keyedBy: CodingKeys.self)
        
        let stringData = try values.decodeIfPresent(String.self, forKey: .data) ?? ""
        data = try Utility.jsonStringToDictionary(string: stringData)
        
        if let anyResult = try values.decodeIfPresent(String.self, forKey: .result) {
            if let objResult = try Utility.jsonStringToDictionary(string: anyResult) {
                result = objResult
            } else if let arrResult = try Utility.jsonStringToArray(string: anyResult) {
                result = arrResult
            } else {
                result = anyResult
            }
        }
        
        let stringDecoder = try values.decodeIfPresent(String.self, forKey: .decoder) ?? ""
        decoder = try Utility.jsonStringToDictionary(string: stringDecoder)
        
        decoded = try values.decodeIfPresent(Bool.self, forKey: .decoded) ?? false
        error = try values.decodeIfPresent(Bool.self, forKey: .error) ?? false
        errorMsg = try values.decodeIfPresent(String.self, forKey: .errorMsg) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(Utility.dictionaryToJsonString(dict: data), forKey: .data)
        try container.encodeIfPresent(Utility.dictionaryToJsonString(dict: decoder), forKey: .decoder)
        try container.encodeIfPresent(decoded, forKey: .decoded)
        try container.encodeIfPresent(error, forKey: .error)
        try container.encodeIfPresent(errorMsg, forKey: .errorMsg)
        if let objResult = result as? [AnyHashable: Any] {
            try container.encodeIfPresent(Utility.dictionaryToJsonString(dict: objResult), forKey: .result)
        } else if let arrResult = result as? [Any] {
            try container.encodeIfPresent(Utility.arrayToJsonString(arr: arrResult), forKey: .result)
        } else if let strResult = result as? String {
            try container.encodeIfPresent(strResult, forKey: .result)
        } else {
            try container.encodeNil(forKey: .result)
        }
    }

}
