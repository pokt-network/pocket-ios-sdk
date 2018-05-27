//
//  ChooseViewController.swift
//  Example
//
//  Created by Michael O'Rourke on 5/26/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import web3swift
class ChooseViewController: UIViewController {

    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let configuration = EthAccountConfiguration(namespace: "wallet", password: nil)
        let (keystore, _) = EthAccountCoordinator.default.launch(configuration)
        
        let jsonKey = "{\"version\":3,\"id\":\"af185f3f-e8f3-463f-ad47-1cdcf94086d9\",\"address\":\"e955199873abd97a921f8b57d27809d57bff6329\",\"Crypto\":{\"ciphertext\":\"476ac878ffdb92c5f969c65cba5574ea13ea73045603011770056711d17464ff\",\"cipherparams\":{\"iv\":\"a23b34daeb9f8ba4951e06cdaf2e8f6e\"},\"cipher\":\"aes-128-ctr\",\"kdf\":\"scrypt\",\"kdfparams\":{\"dklen\":32,\"salt\":\"fa26f38cce0e29215bbef32fdc803b28509475f021a3d7a7170ec9d8c34e3d87\",\"n\":8192,\"r\":8,\"p\":1},\"mac\":\"63fe5b45438aa04318984cb816744296aca9b5a7b3621d91b46e89045c065f56\"}}"
        let currentPassphrase = "123456789"
        let gethAccount = EthAccountCoordinator.default.importPrivateKey(jsonKey, passphrase: currentPassphrase, newPassphrase: currentPassphrase)
    
    
        completeButton.layer.cornerRadius = 5
        completeButton.layer.borderWidth = 1
        completeButton.layer.borderColor = UIColor.black.cgColor
        
        createButton.layer.cornerRadius = 5
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor.black.cgColor


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createQuestPressed(_ sender: Any) {
        presentCreateQuestViewController()
    }
    
    @IBAction func completeQuestPressed(_ sender: Any) {
        presentChooseQuestViewController()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func presentCreateQuestViewController() {
        
        let storyboard = UIStoryboard(name: "CreateQuest", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateVC") as! CreateQuestViewController
        vc.title = "Create"
        navigationController?.navigationBar.backgroundColor = UIColor.yellow
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func presentChooseQuestViewController() {
        
        let storyboard = UIStoryboard(name: "CompleteQuest", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChooseQuestVC") as! ChooseQuestViewController
        vc.title = "Choose Quest"
        navigationController?.navigationBar.backgroundColor = UIColor.yellow
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
