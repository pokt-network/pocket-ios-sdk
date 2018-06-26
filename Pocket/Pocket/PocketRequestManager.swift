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

    var session: URLSession?
    var configuration: URLSessionConfiguration?
    var url: URL?
    
    public init(configuration: URLSessionConfiguration, url: URL) {
        self.configuration = configuration
        self.session = URLSession(configuration: self.configuration!, delegate: nil, delegateQueue: OperationQueue.main)
        self.url = url
    }
    
    public func sendRequest<Model: Encodable>(withURL url: URL, forModel model: Model, completionHandler: @escaping SendRequestHandler) {
        let requestData = try? JSONEncoder().encode(model)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completionHandler(nil, error)
            }
            completionHandler(data, nil)
        }.resume()
    }
}
