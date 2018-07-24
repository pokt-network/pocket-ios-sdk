//
//  JSON.swift
//  Example
//
//  Created by Luis De Leon on 7/23/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public enum JSONError: Error {
    case encodingError
}

public enum JSON: Codable {
    case integer(Int)
    case double(Double)
    case string(String)
    case boolean(Bool)
    case array([JSON])
    case object([String: JSON])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let bool = try? container.decode(Bool.self) {
            self = .boolean(bool)
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let number = try? container.decode(Double.self) {
            self = .double(number)
        } else if let int = try? container.decode(Int.self) {
            self = .integer(int)
        } else if let array = try? container.decode([JSON].self) {
            self = .array(array)
        } else if let dict = try? container.decode([String: JSON].self) {
            self = .object(dict)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Could not decode data into a JSON-compatible value")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let int):
            try container.encode(int)
        case .double(let number):
            try container.encode(number)
        case .string(let string):
            try container.encode(string)
        case .boolean(let bool):
            try container.encode(bool)
        case .array(let jsonArray):
            try container.encode(jsonArray)
        case .object(let jsonObject):
            try container.encode(jsonObject)
        }
    }
    
    public static func valueToJsonPrimitive(anyValue: Any) throws -> JSON {
        let result: JSON
        if let bool = anyValue as? Bool {
            result = .boolean(bool)
        } else if let string = anyValue as? String {
            result = .string(string)
        } else if let number = anyValue as? Double {
            result = .double(number)
        } else if let int = anyValue as? Int {
            result = .integer(int)
        } else if let array = anyValue as? [Any] {
            result = .array(try array.map({ (anyArrValue) -> JSON in
                return try JSON.valueToJsonPrimitive(anyValue: anyArrValue)
            }))
        } else if let dict = anyValue as? [AnyHashable: Any] {
            result = .object(try dict.reduce(into: [String: JSON](), { (result, entry) in
                guard let stringKey = entry.key as? String else {
                    throw JSONError.encodingError
                }
                let jsonValue = try JSON.valueToJsonPrimitive(anyValue: entry.value)
                result[stringKey] = jsonValue
            }))
        } else {
            throw JSONError.encodingError
        }
        return result
    }
    
    public func value() -> Any {
        switch self {
        case .integer(let int):
            return int
        case .double(let number):
            return number
        case .string(let string):
            return string
        case .boolean(let bool):
            return bool
        case .array(let jsonArray):
            return jsonArray
        case .object(let jsonObject):
            return jsonObject
        }
    }
}
