//
//  ItemCell.swift
//  Homepwner-Ch_09
//
//  Created by Geoffrey Dudgeon on 10/7/15.
//  Copyright © 2015 Geoff Dudgeon. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    // MODEL:
    
    
    // VIEW:
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        serialNumberLabel.font = caption1Font
    }
    
    // CONTROLLER:
    
    
}
