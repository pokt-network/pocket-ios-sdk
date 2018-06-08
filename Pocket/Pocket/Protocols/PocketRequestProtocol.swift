//
//  PocketRequestProtocol.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/8/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol PocketRequestProtocol: AnyObject{
    func toJSON() -> JSON
}
