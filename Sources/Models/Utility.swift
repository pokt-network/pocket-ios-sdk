//
//  Utility.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/12/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public struct Utility {

    public static func jsonStringToDictionary(string: String) throws -> [AnyHashable: Any]? {
        guard let object = string.data(using: .utf8, allowLossyConversion: false) else {
            throw NSError()
        }

        guard let rawData = try JSONSerialization.jsonObject(with: object, options: .allowFragments) as? [AnyHashable: Any] else {
            throw NSError()
        }

        return rawData
    }
    
    public static func jsonStringToArray(string: String) throws -> [Any]? {
        guard let object = string.data(using: .utf8, allowLossyConversion: false) else {
            throw NSError()
        }
        
        guard let rawData = try JSONSerialization.jsonObject(with: object, options: .allowFragments) as? [Any] else {
            throw NSError()
        }
        
        return rawData
    }

    public static func dictionaryToJsonString(dict: [AnyHashable: Any]?) throws -> String? {
        let object = dict ?? [AnyHashable: Any]()
        let data = try JSONSerialization.data(withJSONObject: object, options: .sortedKeys)
        return String(data: data, encoding: .utf8)
    }
    
    public static func arrayToJsonString(arr: [Any]?) throws -> String? {
        let array = arr ?? [Any]()
        let data = try JSONSerialization.data(withJSONObject: array, options: .sortedKeys)
        return String(data: data, encoding: .utf8)
    }

}
