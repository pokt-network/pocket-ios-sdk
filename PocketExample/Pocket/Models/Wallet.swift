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
     
     Example:
     
     let passphrase = "thisisapasphrase"
     
     let network = Network(tokenID: "ETH")
     
     let wallet = createWalletWith(passphrase: passphrase, network: network)
     
     Creates a new Wallet for Ethereum network
     
     - **Returns**:
     
        A Wallet type object
     
     - **Parameters**:
     
        - passphrase: Passphrase (string) to create the Wallet. Can not be empty.
     
        - network: Network type. Can not be empty.
     
     - **Important**:
     
        Draft method.
     
     - **Version**:
     
        0.1
     
     Uses a passphrase string and a network as parameters to create a wallet
     
     for an especific network.
     
     */
    
    public func createWalletWith(passphrase: String, network: Network) -> Wallet {
        // Create Wallet with passphrase
        return Wallet(address: "", privateKey: "", network: Network(tokenID: ""))
    }
    
    /**
     
     Imports a wallet using a private key
     
     Example:
     
     let privateKey = "longprivatekeystring"
     let address = "0xwalletaddress"
     let network = Network(tokenID: "ETH")
     
     let wallet = importWallet(walletKey: privateKey, address: address, network: network)
     
     Imports a Ethereum Wallet
     
     - **Returns**:
     
        A Wallet type object
     
     - **Parameters**:
     
        - walletKey: Private key (string) to import the Wallet. Can not be empty.
     
        - address: Address related to the Private key (string). Can not be empty.
     
        - network: Network type. Can not be empty.
     
     - **Important**:
     
        Draft method.
     
     - **Version**:
     
        0.1
     
     Uses a private key string to import a wallet for an especific network.
     
     */
    
    public func importWallet(walletKey: String, address: String, network: Network) -> Wallet {
        // Create Wallet from private key
        return Wallet(address: "", privateKey: "", network: Network(tokenID: ""))
    }
}
