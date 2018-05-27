//
//  ChooseQuestViewController.swift
//  Example
//
//  Created by Michael O'Rourke on 5/26/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import UIKit

class ChooseQuestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let questSegueIdentifier = "ShowQuestSegue"
    var currentIndexPath: IndexPath?
    let rawQuests: [[String: String]] = [
        ["name": "Hackerhouse", "tokenName": "CryptoHackers", "hint": "The Lowest a hacker can go", "numTokens": "10", "id": "10001", "latitude": "-34.586015", "longitude": "-58.432309"],
        ["name": "Go back", "tokenName": "CryptoHackers", "hint": "Can't go any further, go back", "numTokens": "7", "id": "10002", "latitude": "-34.585719", "longitude": "-58.432419"]
    ]
    
    var quests = [Quest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for quest in rawQuests{
            let latitude = quest["latitude"]! as NSString
            let longitude = quest["longitude"]! as NSString
            quests.append(Quest(name: quest["name"], tokenName: quest["tokenName"], hint: quest["hint"], numTokens: Int32(quest["numTokens"] ?? "0")!, id: Int32(quest["id"] ?? "0")!, latitude: latitude.doubleValue, longitude: longitude.doubleValue))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChooseQuestTableViewCell
        
        if indexPath.row > quests.count {
            print("IndexPath.row is higher than Quests count")
            return UITableViewCell.init()
        }
        
        let quest = quests[indexPath.row]
        
        cell?.questNameLabel?.text = quest.name
        cell?.tokenCountsLabel?.text = quest.numTokens?.description
        cell?.questHintLabel?.text = quest.hint
        return cell ?? UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quests.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndexPath = IndexPath(row: indexPath.row, section: indexPath.section)
        
        let storyboard = UIStoryboard(name: "CompleteQuest", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PlayerVC") as? PlayerMapViewController
        vc?.activeQuest = quests[(currentIndexPath?.row)!]
        
        navigationController?.pushViewController(vc!, animated: true)
        
//        self.performSegue(withIdentifier: "ShowQuestSegue", sender: nil)
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == questSegueIdentifier) {
            let vc = segue.destination as? PlayerMapViewController
            let _ = tableView.indexPathForSelectedRow?.row
            vc?.activeQuest = quests[(currentIndexPath?.row)!]
            //destination.blogName = swiftBlogs[blogIndex]
        }
    }

}
