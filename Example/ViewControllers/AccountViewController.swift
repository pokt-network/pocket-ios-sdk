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
        // Do any additional setup after loading the view.
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
    
}
