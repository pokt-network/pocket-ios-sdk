//
//  QueryResponse.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/5/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public struct QueryResponse {
    public var queryObj = Query()
    public var result: Dictionary<AnyHashable, Any>?
    public var decoded = false
    public var error = false
    public var error_msg = ""
}
