//
//  Networking.swift
//  Example
//
//  Created by Michael O'Rourke on 5/25/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

struct Quest: Codable {
    
    let title: String
    let lives: Int // number of tries left to complete
    let merkleRoot: String
    let hint: String

    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        lives = try values.decode(Int.self, forKey: .lives)
        merkleRoot = try values.decode(String.self, forKey: .merkleRoot)
        hint = try values.decode(String.self, forKey: .hint)
    }
    func encode(to encoder: Encoder) throws {
        
    }

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case lives = "lives"
        case merkleRoot = "merkleRoot"
        case hint = "hint"
        
    }
}


struct QuestToken: Codable {
    
    let name: String
    
    
}

enum Result<Value> {
    case success(Value)
    case failure(Error)
}


func getQuests(for userId: Int, completion: ((Result<[Quest]>) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "jsonplaceholder.typicode.com"
    urlComponents.path = "/posts"
    let userIdItem = URLQueryItem(name: "userId", value: "\(userId)")
    urlComponents.queryItems = [userIdItem]
    guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
        DispatchQueue.main.async {
            if let error = responseError {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                // Now we have jsonData, Data representation of the JSON returned to us
                // from our URLRequest...
                
                // Create an instance of JSONDecoder to decode the JSON data to our
                // Codable struct
                let decoder = JSONDecoder()
                
                do {
                    // We would use Post.self for JSON representing a single Post
                    // object, and [Post].self for JSON representing an array of
                    // Post objects
                    let posts = try decoder.decode([Quest].self, from: jsonData)
                    completion?(.success(posts))
                } catch {
                    completion?(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                completion?(.failure(error))
            }
        }
    }
    
    task.resume()
}
