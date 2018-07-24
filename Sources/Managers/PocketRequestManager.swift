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

    public static func sendRequest<Model: Encodable>(withURL url: URL,
                                                     forModel model: Model,
                                                     completionHandler: @escaping SendRequestHandler) {
        let requestData = try? JSONEncoder().encode(model)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completionHandler(nil, error)
            }
            completionHandler(data, nil)
        }.resume()
    }
}
