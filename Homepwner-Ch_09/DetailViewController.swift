//
//  DetailViewController.swift
//  Homepwner-Ch_09
//
//  Created by Geoffrey Dudgeon on 10/7/15.
//  Copyright © 2015 Geoff Dudgeon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    // MODEL:
    var item: Item! // looks dangerous to me...
    
    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle =  .NoStyle
        return formatter
    }()
    
    
    // VIEW: 
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    

    
    // CONTROLLER:
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
    }
    
    
    
    
}
