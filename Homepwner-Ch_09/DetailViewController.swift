//
//  DetailViewController.swift
//  Homepwner-Ch_09
//
//  Created by Geoffrey Dudgeon on 10/7/15.
//  Copyright © 2015 Geoff Dudgeon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    
    // MODEL:
    var item: Item! {
        didSet {
            navigationItem.title = item.name // Set VacController title to item title; remember this for later!
        }
    } // looks dangerous to me...
    
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
    
    // Save before returnin to ItemsViewController
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder(s) -- hide keyboard
        view.endEditing(true)
        
        // "Save" changes to item
        item.name = nameField.text ?? "" // [_] may adapt this to require a name, disregard edits if empty
        item.serialNumber = serialNumberField.text // why no optional unwrapping/nil coalescing?
        
        if let valueText = valueField.text, value = numberFormatter.numberFromString(valueText) {
            item.valueInDollars = value.integerValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    // Catch "RETURN" from keyboard, dismiss keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func backGroundTapped(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
}
