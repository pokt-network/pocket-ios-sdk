//
//  CreateQuestViewController.swift
//  Example
//
//  Created by Michael O'Rourke on 5/26/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import UIKit
import MapKit

class CreateQuestViewController: UIViewController {

    @IBOutlet weak var questNameTextField: UITextField!
    @IBOutlet weak var tokenNameTextField: UITextField!
    @IBOutlet weak var hintTextField: UITextField!
    @IBOutlet weak var numberOfTokensTextField: UITextField!
    
    var questModel: Quest?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextSegue" {
            
                let controller = segue.destination as! ChooseCoordinatesViewController
                controller.questModel = questModel
            
        }
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        questModel = Quest.init(name: questNameTextField.text ?? "", tokenName: tokenNameTextField.text ?? "", hint: hintTextField.text ?? "", numTokens: Int32(numberOfTokensTextField.text ?? "1")!, id: Int32(0), latitude: 0.0, longitude: 0.0)
        
    }
    
}
