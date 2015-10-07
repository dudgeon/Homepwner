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
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // if the table view is asking to commit a delete command...
        if editingStyle == .Delete {
            let item = itemStore.allItems[indexPath.row]
            
            // remove the item from the store
            itemStore.removeItem(item)
            
            // also remove that row from the table view with an animation
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
    }
    
    // enable MOVING items within table view
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // update the model
        itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }

    
    
    // how many rows?
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    
    // this will get execute once for each row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // doing this to adopt our custom TableViewCell -- get new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        
        // commented out on page 139 to enable custom TableViewCell
        // create an instance of UITableViewCell, with default appearance
        //let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell") // don't forget to set the cell Reuse Identifier in the storyboard!!!
        //let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // Update the labels for the new preferred text size
        cell.updateLabels()
        
        // set the text on the cell with the descriotion of the item
        let item = itemStore.allItems[indexPath.row]
        
        // commented out on page 139 to enable custom TableViewCell
        //cell.textLabel?.text = item.name // not sure why we need to optioinal-chain textLabel on assignment....
        //cell.detailTextLabel?.text = "\(item.valueInDollars)"
        
        // doing this to adopt our custom TableViewCell (p. 139) -- Configure the cell with the Item
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
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
        
        // for now, tableView needs to know the height of our cutom row ([_] there is a programmatic way to do this, we will do it later
        // tableView.rowHeight = 65
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
    }
    
    // PREPARE FOR SEGUE
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // if the triggered segue is the "ShowItem" segue
        if segue.identifier == "ShowItem" {
            
            // figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destinationViewController as! DetailViewController // hmm... first time seeing us create an instance of a view controller...
                detailViewController.item = item
                
            }
        }
    }
    
    // PREPARE TO RETURN FROM DetailViewController
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
}
