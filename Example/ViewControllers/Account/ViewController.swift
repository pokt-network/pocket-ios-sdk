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
        
        print(EthAccountCoordinator.default.account?.getAddress().getHex())

        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            // process files
            print(fileURLs)
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
        //print(datadir + "/keystore")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        let configuration = EthAccountConfiguration(namespace: "wallet", password: passphraseTextField.text)
        
//        if passphraseTextField.text?.count ?? 0 == 0 {
//            print("No passphrase, returning")
//            return
//        }
        
        
        let datadir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

        let ks = GethNewKeyStore(datadir + "/keystore", GethLightScryptN, GethLightScryptP);

        
        let (_, account): (GethKeyStore?,GethAccount?) = EthAccountCoordinator.default.launch(configuration)
        
        //let ks = GethNewKeyStore("/path/to/keystore", GethLightScryptN, GethLightScryptP);
        
        
//        print(ks?.getAccounts())
//
//        print(keyStore?.getAccounts())
        print(EthAccountCoordinator.default.account?.getAddress().getHex())
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
    
    
    
    func presentAccountViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "ChooseVC")
        
        self.present(mainViewController, animated: true, completion: nil)
    }

}

