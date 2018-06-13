//
//  Query.swift
//  Pocket
//
//  Created by Luis De Leon on 6/13/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public class Query: Codable {
    
    enum CodingKeys : String, CodingKey {
        case network
        case data = "query"
        case decoder
    }
    
    public var network = ""
    public var data: [AnyHashable: Any]?
    public var decoder: [AnyHashable: Any]?
    
    public init() {
        
    }
    
    public required init(from decodable: Decoder) throws {
        let values = try decodable.container(keyedBy: CodingKeys.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            //try container.encode(serializedTx, forKey: .serializedTx)
            //try container.encode(dictionaryToJsonString(dict: txMetadata), forKey: .txMetadata)
        } catch {
            print(error)
        }
    }
}
