//
//  ChooseQuestTableViewCell.swift
//  Example
//
//  Created by Pabel Nunez Landestoy on 5/27/18.
//  Copyright © 2018 Pocket Network. All rights reserved.
//

import UIKit

class ChooseQuestTableViewCell: UITableViewCell {

    @IBOutlet weak var questNameLabel: UILabel!
    @IBOutlet weak var tokenCountsLabel: UILabel!
    @IBOutlet weak var questHintLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        questNameLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
