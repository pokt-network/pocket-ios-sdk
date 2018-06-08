//
//  Transaction.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public struct Transaction {
    public var network: Network?
    public var serialized_tx = ""
    public var tx_metadata = Dictionary<AnyHashable, Any>()

}
