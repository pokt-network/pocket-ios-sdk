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

struct Pocket {
    
    // Definitions
    private typealias ExecuteRequestHandler<T: Decodable> = (_: T?, _:Error?) -> Void
    
    // State
    var requestManager:PocketRequestManager
    static var pocketInstance:Pocket?
    let pocketNodeURL:URL
    let pocketNodeTxURL:URL
    let pocketNodeQueryURL:URL
    
    static func getInstance(pocketNodeURL: URL) -> Pocket {
        if(pocketInstance == nil) {
            let configuration = URLSessionConfiguration.ephemeral
            let requestManager = PocketRequestManager.init(configuration: configuration, url: pocketNodeURL)
            pocketInstance = Pocket(pocketNodeURL: pocketNodeURL, requestManager: requestManager)
        }
        return pocketInstance!
    }
    
    init(pocketNodeURL: URL, requestManager: PocketRequestManager){
        self.pocketNodeURL = pocketNodeURL
        self.requestManager = requestManager
        self.pocketNodeTxURL = pocketNodeURL.appendingPathComponent("/transactions", isDirectory: false)
        self.pocketNodeQueryURL = pocketNodeURL.appendingPathComponent("/queries", isDirectory: false)
    }
    
    // Executes a request and generically decodes it depending on the decodableType
    private func executeRequest<T: Decodable>(request: Codable, decodableType: T.Type, handler: @escaping ExecuteRequestHandler<T>) {
        
        requestManager.sendRequest(url: self.pocketNodeTxURL, request: request) { (rawResponse, error) in
            guard error == nil else {
                handler(nil, error);
                return;
            }

            guard let responseData = rawResponse else {
                handler(nil, nil)
                return;
            }

            do {
                let response = try JSONDecoder().decode(decodableType, from: responseData)
                handler(response, nil)
            } catch {
                handler(nil, nil);
            }
        }
    }
    
    public func sendTransaction(tx: Transaction, handler: @escaping TransactionHandler) {
        executeRequest(request: tx, decodableType: TransactionResponse.self, handler: handler);
    }
    
    public func executeQuery(query: Query, handler: @escaping ExecuteQueryHandler) {
        executeRequest(request: query, decodableType: QueryResponse.self, handler: handler);
    }
}
