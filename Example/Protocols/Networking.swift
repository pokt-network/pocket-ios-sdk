//
//  Networking.swift
//  Example
//
//  Created by Michael O'Rourke on 5/25/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import Geth
import web3swift
import SwiftyJSON
import MapKit
import CryptoSwift

let QUEST_CONTRACT_ADDRESS = "0xA936Acd9D57Cf8b11EA42985045Ff7a9DB9008e6"
let COORDS_INCREMENT = 0.0000001

struct EthQuery: Codable {
    let from: String?
    let to: String?
    let data: String?
    let value: Int32?
    let gas: Int32?
    let gasPrice: Int32?
    let nonce: Int32?
}

func buildEthQuery(from: String?, to: String?, data: String?, value: Int32?, gas: Int32?, gasPrice: Int32?, nonce: Int32?) -> EthQuery {
    let result = EthQuery(from: from, to: to, data: data, value: value, gas: gas, gasPrice: gasPrice, nonce: nonce);
    return result;
}

struct PoktRequest: Codable {
    let network: String?
    let transaction: String?
    let query: EthQuery?
    let type: String?
    let sender: String?
    let response: String?
    let queryResponse: String?
}

func buildPoktRequest(network: String?, transaction: String?, query: EthQuery?, type: String?, sender: String?, response: String?, queryResponse: String?) -> PoktRequest {
    let result = PoktRequest(network: network, transaction: transaction, query: query, type: type, sender: sender, response: response, queryResponse: queryResponse);
    return result;
}

func getTransactionCount(address: String, completion: @escaping (Int32) -> Void) {
    let ethTxCountFunc = EthFunction(name: "eth_getTransactionCount", inputParameters: [address, "latest"])
    let encodedTxCountFunc = web3swift.encode(ethTxCountFunc)
    let ethQuery = buildEthQuery(from: address, to: nil, data: encodedTxCountFunc.toHexString(), value: 0, gas: nil, gasPrice: nil, nonce: nil)
    let poktRequest = buildPoktRequest(network: "ETH", transaction: nil, query: ethQuery, type: "READ", sender: address, response: nil, queryResponse: nil);
    sendPoktRequest(poktRequest: poktRequest) { (response) in
        if (response != JSON.null) {
            let queryResponse = response["queryResponse"].stringValue
            let scanner = Scanner(string: queryResponse)
            var value: Int32 = 0
            if scanner.scanInt32(&value) {
                completion(value)
            } else {
                completion(0)
            }
        } else {
            completion(0)
        }
    }
}

func getQuestList(from: String, completion: @escaping (Array<Quest>) -> Void) {
    let getQuestListFx = EthFunction(name: "getQuestList", inputParameters: [])
    let encodedTxCountFunc = web3swift.encode(getQuestListFx)
    let ethQuery = buildEthQuery(from: from, to: QUEST_CONTRACT_ADDRESS, data: encodedTxCountFunc.toHexString(), value: 0, gas: nil, gasPrice: nil, nonce: nil)
    let poktRequest = buildPoktRequest(network: "ETH", transaction: nil, query: ethQuery, type: "READ", sender: from, response: nil, queryResponse: nil);
    sendPoktRequest(poktRequest: poktRequest) { (response) in
        var result = [Quest]()
        if (response != JSON.null) {
            let questIdList = response["queryResponse"].array
            questIdList!.forEach({ (questId) in
                let scanner = Scanner(string: questId.stringValue)
                var value: Int32 = 0
                if scanner.scanInt32(&value) {
                    result.append(Quest(name: nil, tokenName: nil, hint: nil, numTokens: nil, id: value))
                }
            });
        } else {
            completion(result)
        }
    }
}

func getQuest(from: String, questId: Int32, completion: @escaping (Quest?) -> Void) {
    let getQuestFx = EthFunction(name: "getQuest", inputParameters: [questId])
    let encodedTxCountFunc = web3swift.encode(getQuestFx)
    let ethQuery = buildEthQuery(from: from, to: QUEST_CONTRACT_ADDRESS, data: encodedTxCountFunc.toHexString(), value: 0, gas: nil, gasPrice: nil, nonce: nil)
    let poktRequest = buildPoktRequest(network: "ETH", transaction: nil, query: ethQuery, type: "READ", sender: from, response: nil, queryResponse: nil);
    sendPoktRequest(poktRequest: poktRequest) { (response) in
        if (response != JSON.null) {
            let questValues = response["queryResponse"].arrayValue
            //Order: name, hint, merkleRoot, creatorAddress, tokenName, numTokens
            let quest = Quest(name: questValues[0].stringValue, tokenName: questValues[4].stringValue, hint: questValues[1].stringValue, numTokens: questValues[5].int32Value, id: questId)
            completion(quest)
        } else {
            completion(nil)
        }
    }
}

func createQuest(from: String, quest: Quest, lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (Quest?) -> Void) {
    let merkleRoot = createMerkleRoot(lat: lat, lon: lon)
    let createQuestFx = EthFunction(name: "createQuest", inputParameters: [quest.name, quest.hint, quest.tokenName, GethBigInt(Int64(quest.numTokens!)), merkleRoot])
    let encodedTxCountFunc = web3swift.encode(createQuestFx)
    getTransactionCount(address: from) { (txCount) in
        var nonce = txCount
        if (nonce != 0) {
            nonce = nonce + 1
        }
        let signedTransaction = web3swift.sign(address: GethAddress(fromHex: QUEST_CONTRACT_ADDRESS), encodedFunctionData: encodedTxCountFunc, nonce: Int64(nonce), gasLimit: GethNewBigInt(6721975), gasPrice: GethNewBigInt(20000000))
        let signedTxData = try! signedTransaction?.encodeRLP()
        let poktRequest = buildPoktRequest(network: "ETH", transaction: signedTxData!.toHexString(), query: nil, type: "WRITE", sender: from, response: nil, queryResponse: nil)
        sendPoktRequest(poktRequest: poktRequest, completion: { (response) in
            completion(quest)
        })
    }
}

func createMerkleRoot(lat: CLLocationDegrees, lon: CLLocationDegrees) -> String?  {
    let possiblePoints = getAllPossiblePoints(lat: lat, lon: lon)
    var hashes = [Data]()
    for point in possiblePoints {
        hashes.append(hashCoordinates(coords: point)!)
    }
    var rootData = Data()
    for hash in hashes {
        rootData.append(Data(hash))
    }
    return rootData.sha256().toHexString()
}

func verifyMerkleProof(merkleRoot: String, lat: CLLocationDegrees, lon: CLLocationDegrees) -> Bool {
    var result = false
    
    let coords = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    let coordsHash = hashCoordinates(coords: coords)
    let siblingHash = hashCoordinates(coords: CLLocationCoordinate2D(latitude: lat.magnitude + COORDS_INCREMENT, longitude: lon.magnitude + COORDS_INCREMENT))
    
    var possibleRoot = Data()
    possibleRoot.append(coordsHash!)
    possibleRoot.append(siblingHash!)
    let possibleRootStr = String(data: possibleRoot.sha256(), encoding: String.Encoding.utf8) as String!
    
    if merkleRoot.elementsEqual(possibleRootStr!) {
        result = true
    }
    return result
}

func submitQuestProof(from: String, quest: Quest, lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping () -> Void) {
    
    let coords = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    let coordsHash = hashCoordinates(coords: coords)
    let siblingHash = hashCoordinates(coords: CLLocationCoordinate2D(latitude: lat.magnitude + COORDS_INCREMENT, longitude: lon.magnitude + COORDS_INCREMENT))
    
    let proveLocationFx = EthFunction(name: "proveLocation", inputParameters: [quest.id, [siblingHash], coordsHash as Any])
    let encodedTxCountFunc = web3swift.encode(proveLocationFx)
    getTransactionCount(address: from) { (txCount) in
        let nonce = txCount + 1
        let signedTransaction = web3swift.sign(address: GethAddress(fromHex: from), encodedFunctionData: encodedTxCountFunc, nonce: Int64(nonce), gasLimit: GethNewBigInt(6721975), gasPrice: GethNewBigInt(20000000000))
        let signedTxData = try! signedTransaction?.encodeRLP()
        let poktRequest = buildPoktRequest(network: "ETH", transaction: signedTxData!.toHexString(), query: nil, type: "WRITE", sender: from, response: nil, queryResponse: nil)
        sendPoktRequest(poktRequest: poktRequest, completion: { _ in
            completion()
        })
    }
    
}

func hashCoordinates(coords: CLLocationCoordinate2D) -> Data? {
    let locStr = String(coords.latitude.magnitude) + String(coords.longitude.magnitude)
    let locData = locStr.data(using: .utf8)
    return locData!.sha256()
}

func getAllPossiblePoints(lat: CLLocationDegrees, lon: CLLocationDegrees) -> [CLLocationCoordinate2D] {
    let distance = 0.001
    let radius = 6371.0
    let quotient = distance/radius
    
    let maxLat = lat.magnitude + radiansToDegrees(quotient)
    let minLat = lat.magnitude - radiansToDegrees(quotient)
    
    let maxLon = lon.magnitude + radiansToDegrees(quotient)
    let minLon = lon.magnitude - radiansToDegrees(quotient)
    
    var latList = [CLLocationDegrees]()
    var lonList = [CLLocationDegrees]()
    var coordList = [CLLocationCoordinate2D]()
    
    var currentLat = minLat
    var currentLon = minLon
    
    while currentLat <= maxLat {
        latList.append(CLLocationDegrees.init(currentLat))
        currentLat = currentLat + COORDS_INCREMENT
    }
    
    while currentLon <= maxLon {
        lonList.append(CLLocationDegrees.init(currentLon))
        currentLon = currentLon + COORDS_INCREMENT
    }
    
    for lat in latList {
        for lon in lonList {
            coordList.append(CLLocationCoordinate2D.init(latitude: lat, longitude: lon))
        }
    }
    
    return coordList
}

func sendPoktRequest(poktRequest: PoktRequest, completion: @escaping (JSON) -> Void) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "http"
    urlComponents.host = "127.0.0.1"
    urlComponents.port = 3000
    urlComponents.path = "/relays"
    guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
    
    // Specify this request as being a POST method
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // Make sure that we include headers specifying that our request's HTTP body
    // will be JSON encoded
    var headers = request.allHTTPHeaderFields ?? [:]
    headers["Content-Type"] = "application/json"
    request.allHTTPHeaderFields = headers
    
    // Now let's encode out Post struct into JSON data...
    let encoder = JSONEncoder()
    do {
        let jsonData = try encoder.encode(poktRequest)
        // ... and set our request's HTTP body
        request.httpBody = jsonData
        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
    } catch {
        print("Error sending Pokt Request");
    }
    
    // Create and run a URLSession data task with our JSON encoded POST request
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
        guard responseError == nil else {
            print("Error receiving Pokt Response")
            return
        }
        do {
            let json = try JSON(data: responseData!)
            completion(json)
        } catch {
            print("Unexpected error: \(error).")
            completion(JSON.null);
        }
    }
    task.resume()
}
