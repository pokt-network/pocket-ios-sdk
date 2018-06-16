//
//  Wallet.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public struct Wallet {
    public var address = ""
    public var privateKey = ""
    public var network = ""
    public var data:[AnyHashable : Any]? = [AnyHashable : Any]()
    
    public init(address: String, privateKey: String, network: String, data: [AnyHashable : Any]?) {
        self.address = address
        self.privateKey = privateKey
        self.network = network
        self.data = data
    }
}
