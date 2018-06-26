//
//  PocketRequestManager.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/7/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public typealias SendRequestHandler = (_: Data?, _: Error?) -> Void

public struct PocketRequestManager {

    public var session: URLSession?
    public var configuration: URLSessionConfiguration?
    public var url: URL?
    
    init(configuration: URLSessionConfiguration, url: URL) {
        self.configuration = configuration
        self.session = URLSession(configuration: self.configuration!, delegate: nil, delegateQueue: OperationQueue.main)
        self.url = url
    }
    
    public func sendRequest(withURL url: URL, forModel model: Encodable, completionHandler: @escaping SendRequestHandler) {
        let requestData = try? JSONSerialization.data(withJSONObject: model)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error);
                return
            }
            completionHandler(data, nil)
        }
        
        task.resume()
    }
}
