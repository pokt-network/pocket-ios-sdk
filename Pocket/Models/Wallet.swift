//
//  Wallet.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 4/24/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation

public struct Wallet {
    public var address = ""
    public var privateKey = ""
    public var network: Network?
    
    /**
     Creates a wallet using a string for an especific network

     ```
     // Example: Creates a new Wallet for Ethereum network.
     let passphrase = "thisisapasphrase"
     let network = Network(tokenID: "ETH")
     let wallet = createWalletWith(passphrase: passphrase, network: network)
     ```

     - Parameters:
        - passphrase: Passphrase (string) to create the Wallet. Can not be empty.
        - network: Network type. Can not be empty.

     - Returns: A Wallet type object
     */
    public func createWallet(withPassphrase passphrase: String, network: Network) -> Wallet {
        return Wallet(address: "", privateKey: "", network: Network(tokenID: ""))
    }
    
    /**
     Imports a wallet using a private key.

     ```
     // Example: Imports an Ethereum Wallet.
     let privateKey = "longprivatekeystring"
     let address = "0xwalletaddress"
     let network = Network(tokenID: "ETH")
     let wallet = importWallet(walletKey: privateKey, address: address, network: network)
     ```

     - Parameters:
        - key: Private key (string) to import the Wallet.
        - address: Address related to the Private key (string).
        - network: Network type. Can not be empty.

     - Returns: A Wallet type object
     */
    public func importWallet(withKey key: String, address: String, network: Network) -> Wallet {
        return Wallet(address: "", privateKey: "", network: Network(tokenID: ""))
    }
}
