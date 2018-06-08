//
//  PocketRequestManagerProtocol.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/7/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftyJSON

public typealias SendRequestHandler = (_: JSON, _: Error?) -> Void

public protocol PocketRequestManagerProtocol: AnyObject {
    func sendRequest(request: PocketRequestProtocol, completionHandler: @escaping SendRequestHandler)
}
