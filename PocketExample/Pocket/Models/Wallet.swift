//
//  Wallet.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

struct Wallet {
    var address = ""
    var privateKey = ""
    var network: Network?

    func createWalletWith(passphrase: String, network: Network) -> Wallet {
        // Create Wallet with passphrase
        return Wallet(address: "", privateKey: "", network: Network(tokenID: ""))
    }
    
    func importWallet(walletKey: String, address: String, network: Network) -> Wallet {
        // Create Wallet from private key
        return Wallet(address: "", privateKey: "", network: Network(tokenID: ""))
    }
}
