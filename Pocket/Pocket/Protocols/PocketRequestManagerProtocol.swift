//
//  PocketRequestManagerProtocol.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/7/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public typealias SendRequestHandler = (_: Decoder, _: Error?) -> Void

public protocol PocketRequestManagerProtocol: AnyObject {
    func sendRequest(request: Encoder, completionHandler: @escaping SendRequestHandler)
}
