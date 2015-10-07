//
//  ItemStore.swift
//  Homepwner-Ch_09
//
//  Created by Geoffrey Dudgeon on 10/6/15.
//  Copyright © 2015 Geoff Dudgeon. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    // the func that ItemsViewController will call to create a new item:
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    // let's create five items
    //    init() {
    //        for _ in 0..<5 {
    //            createItem()
    //        }
    //    }
    

    // providing a delete action to pass to the table view commitEditingStyle 'method'
    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    // provide a move action to pass to...
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // GET REFERENCE to object being moved so you can re-insert it
        let movedItem = allItems[fromIndex]
        
        // REMOVE item from array
        allItems.removeAtIndex(fromIndex)
        
        // INSERT item in array at new location
        allItems.insert(movedItem, atIndex: toIndex)
    }
    
    
}
