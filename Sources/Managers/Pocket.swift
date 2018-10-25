//
//  Pocket.swift
//  Pocket
//
//  Created by Luis De Leon on 6/5/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public typealias TransactionHandler = (TransactionResponse?, Error?) -> Void
public typealias ExecuteQueryHandler = (QueryResponse?, Error?) -> Void

public enum PocketError: Error {
    case configurationError
}

public class Pocket {

    // Singleton
    public static let shared = Pocket()

    // Dependency Injected Configuration
    public var configuration: Configuration?

    /// Initializer
    public init() {
        // Empty for now
    }
    
    // Configuration setup
    public func setConfiguration(config: Configuration){
        self.configuration = config
    }

    public func sendTransaction(transaction: Transaction, handler: @escaping TransactionHandler) {
        guard let url = configuration?.nodeURL else {
            handler(nil, PocketError.configurationError)
            return // Handle Error
        }

        executeRequest(withURL: url.appendingPathComponent("/transactions", isDirectory: false),
                       forModel: transaction,
                       ofType: TransactionResponse.self,
                       handler: handler)
    }
    
    public func executeQuery(query: Query, handler: @escaping ExecuteQueryHandler) {
        guard let url = configuration?.nodeURL else {
            handler(nil, PocketError.configurationError)
            return // Handle Error
        }

        executeRequest(withURL: url.appendingPathComponent("/queries", isDirectory: false),
                       forModel: query,
                       ofType: QueryResponse.self,
                       handler: handler)
    }
}

private extension Pocket {
    typealias ExecuteRequestHandler<Response: Decodable> = (Response?, Error?) -> Void

    // Executes a request and generically decodes it depending on the decodableType
    func executeRequest<Model: Encodable, Response: Decodable>(withURL url: URL,
                                                               forModel model: Model,
                                                               ofType type: Response.Type,
                                                               handler: @escaping ExecuteRequestHandler<Response>) {
        PocketRequestManager.sendRequest(withURL: url, forModel: model) { response, error in
            guard error == nil else {
                return handler(nil, error)
            }

            guard let response = response else {
                return handler(nil, nil)
            }

            do {
                let response = try JSONDecoder().decode(type, from: response)
                handler(response, nil)
            } catch {
                handler(nil, nil)
            }
        }
    }
}
