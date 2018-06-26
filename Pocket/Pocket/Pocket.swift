//
//  Pocket.swift
//  Pocket
//
//  Created by Luis De Leon on 6/5/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public typealias TransactionHandler = (_: TransactionResponse?, _: Error?) -> Void
public typealias ExecuteQueryHandler = (_: QueryResponse?, _:Error?) -> Void

public struct Pocket {

    public static var pocketInstance: Pocket?

    var requestManager: PocketRequestManager
    var pocketNodeURL: URL

    public static func getInstance(forURL url: URL) -> Pocket {
        guard let pocketInstance = pocketInstance else {
            let configuration = URLSessionConfiguration.ephemeral
            let requestManager = PocketRequestManager(configuration: configuration, url: url)
            return Pocket(pocketNodeURL: url, requestManager: requestManager)
        }

        return pocketInstance
    }

    public init(pocketNodeURL: URL, requestManager: PocketRequestManager) {
        self.pocketNodeURL = pocketNodeURL
        self.requestManager = requestManager
    }

    public func sendTransaction(transaction: Transaction, handler: @escaping TransactionHandler) {
        executeRequest(withURL: pocketNodeURL.appendingPathComponent("/transactions", isDirectory: false),
                       forModel: transaction,
                       ofType: TransactionResponse.self,
                       handler: handler)
    }
    
    public func executeQuery(query: Query, handler: @escaping ExecuteQueryHandler) {
        executeRequest(withURL: pocketNodeURL.appendingPathComponent("/queries", isDirectory: false),
                       forModel: query,
                       ofType: QueryResponse.self,
                       handler: handler)
    }
}

private extension Pocket {
    typealias ExecuteRequestHandler<T: Decodable> = (T?, Error?) -> Void

    // Executes a request and generically decodes it depending on the decodableType
    func executeRequest<T: Decodable>(withURL url: URL, forModel model: Codable, ofType type: T.Type, handler: @escaping ExecuteRequestHandler<T>) {
        requestManager.sendRequest(withURL: url, forModel: model) { (rawResponse, error) in
            guard error == nil else {
                handler(nil, error)
                return;
            }

            guard let responseData = rawResponse else {
                handler(nil, nil)
                return
            }

            do {
                let response = try JSONDecoder().decode(type, from: responseData)
                handler(response, nil)
            } catch {
                handler(nil, nil)
            }
        }
    }
}
