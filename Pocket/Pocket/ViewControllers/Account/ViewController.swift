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
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var passphraseTextField: UITextField!
    @IBOutlet weak var privateKeyTextView: UITextView!
    @IBOutlet weak var currentPassphraseTextField: UITextField!
    
    @IBOutlet weak var newPassphraseTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = EthAccountConfiguration(namespace: "wallet", password: nil)
        let (keystore, _) = EthAccountCoordinator.default.launch(configuration)
        
        let jsonKey = "{\"version\":3,\"id\":\"af185f3f-e8f3-463f-ad47-1cdcf94086d9\",\"address\":\"e955199873abd97a921f8b57d27809d57bff6329\",\"Crypto\":{\"ciphertext\":\"476ac878ffdb92c5f969c65cba5574ea13ea73045603011770056711d17464ff\",\"cipherparams\":{\"iv\":\"a23b34daeb9f8ba4951e06cdaf2e8f6e\"},\"cipher\":\"aes-128-ctr\",\"kdf\":\"scrypt\",\"kdfparams\":{\"dklen\":32,\"salt\":\"fa26f38cce0e29215bbef32fdc803b28509475f021a3d7a7170ec9d8c34e3d87\",\"n\":8192,\"r\":8,\"p\":1},\"mac\":\"63fe5b45438aa04318984cb816744296aca9b5a7b3621d91b46e89045c065f56\"}}"
        let currentPassphrase = "123456789"
        let gethAccount = EthAccountCoordinator.default.importPrivateKey(jsonKey, passphrase: currentPassphrase, newPassphrase: currentPassphrase)
        if gethAccount != nil {
            presentAccountViewController()
        }else{
            print("Failed to import account")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func presentAccountViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChooseVC")
        
         navigationController?.pushViewController(vc, animated: true)
//        present(mainViewController, animated: true, completion: nil)
    }

}

