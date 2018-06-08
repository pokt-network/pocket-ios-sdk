//
//  PocketRequestManagerProtocol.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/7/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftyJSON

public typealias SendRequestHandler = (_:JSON) -> Void

public protocol PocketRequestManagerProtocol: AnyObject {
    func sendRequest(data: Data, CompletionHandler: @escaping SendRequestHandler)
    func toJSON(data: Data) -> JSON
}
