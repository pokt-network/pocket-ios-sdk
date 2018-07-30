# pocket-ios-sdk
The Pocket iOS SDK contains a generic interface that allows anyone to build a plugin that is specific to any blockchain. The SDK boils down to two main interactions, `sendTransaction`  for writes and `executeQuery` for reads to a given blockchain.  Each plugin will have its own metadata specific to it's own blockchain. All queries and transactions conform to what a Pocket Node is expecting. 

## Install

`pod 'Pocket', :git => 'https://github.com/pokt-network/pocket-ios-sdk.git', :branch => 'master'`

## Primary Models

Constructing reads and writes from blockchains have been modeled out as `Query` and `Transaction`. Successful responses to reads and writes are `QueryResponse` and  `TransactionResponse`. The `Wallet` is the main account system for clients.

## Functionality 

The `PocketPlugin` is a protocol that every Plugin needs to conform to. Please look over the Pocket Ethereum Plugin as an example for implementing on another blockchain.

### Create a wallet

`static func createWallet(data: [AnyHashable: Any]?) throws -> Wallet`

Create a new wallet. Needs to take in data specific for the blockchain. Returns a `Wallet` object.

Wallets can be considered the identity systems or authentication for building blockchain applications. Every blockchain uses a different hashing algorithm to create a wallet. For example, in Ethereum to create an account it must use the keccak256 algortithm.

### Import a wallet

`static func importWallet(privateKey: String, address: String?, data: [AnyHashable: Any]?) throws -> Wallet`

Import any already existing wallet. Need the private key, public key and any extra data. Returns a `Wallet` object.

### Create a transaction

`static func createTransaction(wallet: Wallet, params: [AnyHashable: Any]) throws -> Transaction`

Need a `Wallet` object to be able to sign the transaction with your private keys. Returns `Transaction` object. 

Creating a transaction is a write to a given blockchain. Depending on the blockchain, this can have different confirmation times, and your application's UI will need to reflect that limitation.  

### Creating a Query

`static func createQuery(params: [AnyHashable: Any], decoder: [AnyHashable: Any]?) throws -> Query`

Queries are reads from a blockchain. It creates a request that conforms to the Pocket Node API.


## What is an iOS Plugin?

The Pocket iOS Plugin System allows any iOS app to support any decentralized network that a developer wishes to build upon. It is intended to abstract the complexity of blockchain development to enable developers to build out their applications quickly and easily.

Each plugin can be created independently and supported individually as a Cocoapods package, and each developer can pick and choose whichever plugins they wanna use to support on their network.

For example, if you wanted to add Ethereum support for your app, you can use our Pocket iOS Ethereum Plugin.
