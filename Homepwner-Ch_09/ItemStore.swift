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
    
    
}
