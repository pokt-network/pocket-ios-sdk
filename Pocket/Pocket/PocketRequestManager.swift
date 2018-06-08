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

    public func sendRequest(request: PocketRequestProtocol, completionHandler: @escaping SendRequestHandler) {
        let task = self.session?.dataTask(with: self.url!) { (data, urlResponse, error) in
            let json = try? JSON.init(data: data!)
            completionHandler(json!, error!)
        }
        task?.resume()
    }
    
}
