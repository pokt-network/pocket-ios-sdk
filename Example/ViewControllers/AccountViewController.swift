//
//  AccountViewController.swift
//  Example
//
//  Created by Pabel Nunez Landestoy on 5/21/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import UIKit
import Geth
import web3swift

class AccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var gasPriceLabel: UILabel!
    @IBOutlet weak var gasLimitLabel: UILabel!
    @IBOutlet weak var toAddressTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var accountAddressLabel: UILabel!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    
    let accountAddress = EthAccountCoordinator.default.account?.getAddress()
    var toAccountAddress = ""
    var transferAmount = 0
    var gasPrice = GethNewBigInt(20000000000)!
    var gasLimit = GethNewBigInt(4300000)!
    
    struct Constants {
        static let contractAddress = "0xc4a278103162f47d8aa0212644044564062b09f1"
        static let transferFunctionName = "transfer"
        
        static let serverURL = "https://yourserverhere/"
        static let trasferURL = "contract/send"
        static let nonceURL = "account/getTransactionCount"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let nonce = Int64(0)
//        let toAddress = "0xb3Bd49E28f8F832b8d1E246106991e546c323502"
//        var addressError: NSError? = nil
//        let gethContractAddress = GethNewAddressFromHex(toAddress, &addressError)
//        let amount = GethNewBigInt(1)
//        //let gasLimit = GethNewBigInt(1)
//        //let gasPrice = GethNewBigInt(1)
//        //let data = Data("asd")
//        let data = "any string".data(using: .utf8)
        
        
        //createTransaction(nonce: nonce, toAddress: gethContractAddress!, amount: amount!, gasLimit: gasLimit, gasPrice: gasPrice, data: data!)
        //createTransaction(nonce: nonce, address: toAddress!, encodedFunctionData: data, gasLimit: gasLimit!, gasPrice: gasPrice!, data: data)
        
        // test transaction
        let configB = EthAccountConfiguration(namespace: "walletB", password: "12345")
        let (keystoreB, accountB): (GethKeyStore?,GethAccount?) = EthAccountCoordinator.default.launch(configB)
        
        print(accountAddress)
        
//        if let walletAAccountAddress: GethAddress = accountA?.getAddress() {
            let amount = GethBigInt.bigInt(valueInEther:50)!
            let transferFunction = EthFunction(name: "transfer", inputParameters: [accountAddress!, amount])
//        }
        
        let encodedTransferFunction = web3swift.encode(transferFunction)
        print("\(encodedTransferFunction.toHexString())")
        
        let nonce: Int64 = 0
        let gasPrice = GethNewBigInt(20000000000)!
        let gasLimit = GethNewBigInt(4300000)!
        let contractAddress = "0xb3Bd49E28f8F832b8d1E246106991e546c323502"
        var addressError: NSError? = nil
        let gethContractAddress: GethAddress! = GethNewAddressFromHex(contractAddress, &addressError)
        let signedTx = web3swift.sign(address: gethContractAddress, encodedFunctionData: encodedTransferFunction, nonce: nonce, gasLimit: gasLimit, gasPrice: gasPrice)
        
        let signedTxData = try! signedTx?.encodeRLP()
        print("\(signedTxData!.toHexString())\n\(signedTxData!.bytes)")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountAddressLabel.text = accountAddress?.getHex()
        gasPriceLabel.text = gasPrice.string()
        gasLimitLabel.text = gasLimit.string()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == toAddressTextField {
            toAccountAddress = textField.text ?? ""
        }else if textField == amountTextField {
            transferAmount = Int(textField.text ?? "") ?? 0
        }
    }
    @IBAction func sendAction(_ sender: Any) {
        if toAccountAddress != ""  && transferAmount > 0{
            
        }
    }
    
    func createTransaction(nonce: Int64, toAddress: GethAddress, amount: GethBigInt, gasLimit: GethBigInt, gasPrice: GethBigInt, data: Data) {
        
        
        //let transaction = GethNewTransaction(nonce, toAddress, amount, gasLimit, gasPrice, data)
        
        
        let signedTransaction = sign(address: toAddress, encodedFunctionData: data, nonce: nonce, gasLimit: gasLimit, gasPrice: gasPrice)
        //let signedTransaction = sign(address: toAddress!, encodedFunctionData: data, nonce: nonce, gasLimit: gasLimit!, gasPrice: gasPrice!)
        
        print(signedTransaction!)
        //return transaction!
    }
    
    func sendTransaction () {
        
    }
    
}
