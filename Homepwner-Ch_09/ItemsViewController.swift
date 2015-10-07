//
//  ItemsViewController.swift
//  Homepwner-Ch_09
//
//  Created by Geoffrey Dudgeon on 10/6/15.
//  Copyright © 2015 Geoff Dudgeon. All rights reserved.
//



import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    // Chapter 10: Adding editing functionality
    
    @IBAction func addNewItem(sender: AnyObject) {
        
        // create a new item and add it to the store FIRST!
        let newItem = itemStore.createItem()
        
        // figure out where that item is in the array
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forItem: index, inSection: 0)
            
            // insert this new row into the table
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        
        // if you are currently in editing mode...
        if editing {
            // change text of buttons to inform user of state
            sender.setTitle("Edit", forState: .Normal)
            
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // change text of buttons to inform user of state
            sender.setTitle("Done", forState: .Normal)
            
            // Enter editing mode
            setEditing(true, animated: true)
        }
        
    }
    
    
    // how many rows?
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    
    // this will get execute once for each row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // create an instance of UITableViewCell, with default appearance
        //let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell") // don't forget to set the cell Reuse Identifier in the storyboard!!!
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // set the text on the cell with the descriotion of the item
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name // not sure why we need to optioinal-chain textLabel on assignment....
        cell.detailTextLabel?.text = "\(item.valueInDollars)"
        
        return cell
    }
    
    // pad the top of the tableView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the height of the status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        // adjust the UIEdgeInsets
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
}
