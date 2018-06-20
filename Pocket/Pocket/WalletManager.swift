//
//  WalletManager.swift
//  Pocket
//
//  Created by Pabel Nunez Landestoy on 6/20/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

public struct WalletManager {
    
    public func persistWallet(wallet: Wallet) -> Bool{
        return wallet.save()
    }
    
    public func deleteWallet(wallet: Wallet) -> Bool {
        return wallet.delete()
    }
    
    public func retrieveWalletWithAddress(address: String, network: String) -> [Wallet]{
        let addressWithNetwork = network+address

        let retrievedString: String? = KeychainWrapper.standard.string(forKey: addressWithNetwork)

        let wallet = Wallet(jsonString: retrievedString ?? "")

        return [wallet]
    }
    
    public func retrieveWalletList() -> [Wallet]{
        var wallets = [Wallet]()
        
        let allRecords = KeychainWrapper.standard.allKeys()
        
        for record in allRecords {
            let wallet = Wallet(jsonString: record)
            wallets.append(wallet)
        }
        return wallets
    }
}
