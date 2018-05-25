//
//  ViewController.swift
//  Pocket
//
//  Created by Arthur Sabintsev on 3/18/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import UIKit
import web3swift
import Geth

class ViewController: UIViewController {

    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var passphraseTextField: UITextField!
    @IBOutlet weak var privateKeyTextView: UITextView!
    @IBOutlet weak var currentPassphraseTextField: UITextField!
    
    @IBOutlet weak var newPassphraseTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        let configuration = EthAccountConfiguration(namespace: "wallet", password: passphraseTextField.text)
        
        if passphraseTextField.text?.count ?? 0 == 0 {
            print("No passphrase, returning")
            return
        }
        
        let (_, account) = EthAccountCoordinator.default.launch(configuration)
        
        if account != nil {
            presentAccountViewController()
        } else {
            print("Error creating account.")
        }
        
    }
    @IBAction func importWalletAction(_ sender: Any) {
        let jsonKey = privateKeyTextView.text
        let currentPassphrase = currentPassphraseTextField.text
        let newPassphrase = newPassphraseTextField.text
        
        if isImportWalletInputsValid() {
            let privateKey = EthAccountCoordinator.default.importPrivateKey(jsonKey!, passphrase: currentPassphrase!, newPassphrase: newPassphrase!)
            if privateKey != nil {
                presentAccountViewController()
            }else{
                print("Failed to import account")
            }
        }
        
    }
    
    func isImportWalletInputsValid() -> Bool {
        var bool = true
        
        if (privateKeyTextView.text ?? "").isEmpty {
            bool = false
        }
        
        if (currentPassphraseTextField.text ?? "").isEmpty {
            bool = false
        }
        
        if (newPassphraseTextField.text ?? "").isEmpty {
            bool = false
        }
        
        return bool
    }
    
    func createTransaction() -> GethTransaction {

        let nonce = Int64(0)
        let toAddress = GethAddress(fromHex: "0x")
        let amount = GethNewBigInt(1)
        let gasLimit = Int64(1)
        let gasPrice = GethNewBigInt(1)
        let data = Data()


        let transaction = GethNewTransaction(nonce, toAddress!, amount, gasLimit, gasPrice, data)

        return transaction!
    }
    
    func signTransaction (transaction: GethTransaction) {
        signTransaction(transaction: transaction)
    }
    
    func presentAccountViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "accountViewControllerID")
        
        self.present(mainViewController, animated: true, completion: nil)
    }

}

