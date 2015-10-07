//
//  DetailViewController.swift
//  Homepwner-Ch_09
//
//  Created by Geoffrey Dudgeon on 10/7/15.
//  Copyright © 2015 Geoff Dudgeon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
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
    @IBOutlet var imageView: UIImageView!
    

    
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
    
    
    // MARK: PHOTOS!!!!!

    // Take/Select a Photo
    @IBAction func takePicture(sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        // If the device has a camera, take a picture; otherwise, just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        // Present the image picker
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Catch reference to selected photo
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get picked image from returned info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Put image onto screen in our image view
        imageView.image = image
        
        // Take image picker off the screen -- must call
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    
    // UTILITIES
    
    // Catch "RETURN" from keyboard, dismiss keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func backGroundTapped(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
}
