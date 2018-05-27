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

        completeButton.backgroundColor = .clear
        completeButton.layer.cornerRadius = 5
        completeButton.layer.borderWidth = 1
        completeButton.layer.borderColor = UIColor.black.cgColor
        
        createButton.backgroundColor = .clear
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
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func presentChooseQuestViewController() {
        
        let storyboard = UIStoryboard(name: "CompleteQuest", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChooseQuestVC") as! ChooseQuestViewController
        vc.title = "Choose Quest"
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
