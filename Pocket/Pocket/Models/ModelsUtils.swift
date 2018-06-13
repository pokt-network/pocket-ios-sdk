//
//  ModelsUtils.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/12/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public func jsonStringToDictionary(string: String) throws -> [AnyHashable: Any]? {
    guard let rawData = try JSONSerialization.jsonObject(with: string.data(using: .utf8, allowLossyConversion: false)!, options: .allowFragments) as? [AnyHashable: Any] else {
        throw NSError()
    }
    return rawData
}

public func dictionaryToJsonString(dict: [AnyHashable: Any]?) throws -> String? {
    let data = try JSONSerialization.data(withJSONObject: dict ?? [AnyHashable: Any](), options: .sortedKeys)
    return String.init(data: data, encoding: .utf8)
}
