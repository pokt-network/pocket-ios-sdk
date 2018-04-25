//
//  Wallet.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

class Wallet {
    var address: String
    var privateKey: String
    var network: Network?
    
    init(address: String, privateKey: String, network: Network) {
        self.address = address
        self.privateKey = privateKey
        self.network = network
    }

    func createWalletWith(passphrase: String, network: Network) -> Wallet {
        // Create Wallet with passphrase
        return Wallet(address: "", privateKey: "", network: Network(tokenID: ""))
    }
    
    func importWallet(walletKey: String, address: String, network: Network) -> Wallet {
        // Create Wallet from private key
        return Wallet(address: "", privateKey: "", network: Network(tokenID: ""))
    }
}
