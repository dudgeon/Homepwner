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
    
}
