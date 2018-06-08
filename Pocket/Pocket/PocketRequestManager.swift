//
//  PocketRequestManager.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/7/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PocketRequestManager: NSObject, PocketRequestManagerProtocol {
    public var session: URLSession?
    public var configuration: URLSessionConfiguration?
    public var url: URL?
    
    init(configuration: URLSessionConfiguration, url: URL) {
        self.configuration = configuration
        self.session = URLSession(configuration: self.configuration!, delegate: nil, delegateQueue: OperationQueue.main)
        self.url = url
    }

    public func sendRequest(data: Data, CompletionHandler: @escaping (JSON) -> Void) {
        let task = self.session?.dataTask(with: self.url!) { (data, urlResponse, error) in
            if error != nil {
                let json = self.toJSON(data: Data.init())
                CompletionHandler(json)
            }else {
                let json = self.toJSON(data: data!)
                CompletionHandler(json)
            }
        }
        task?.resume()
    }
    
    public func toJSON(data: Data) -> JSON {
        let json = toJSON(data: data)
        return json
    }
    
}
