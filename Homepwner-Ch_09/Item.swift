//
//  Item.swift
//  Homepwner-Ch_09
//
//  Created by Geoffrey Dudgeon on 10/6/15.
//  Copyright © 2015 Geoff Dudgeon. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: NSDate
    let itemKey: String
    
    
    //: MARK: Initialize
    init(name: String, serialNumber: String?, valueInDollars: Int) { // this is our 'Designated Initializer'
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().UUIDString
        
        super.init() // needed because we are inheriting from the NSObject base class (or really, any SuperClass)
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny", "Awesome", "Vigorous", "Terrible", "Slippery"]
            let nouns = ["Bear", "Otter", "Spork", "External Monitor", "Canoe", "Unicycle"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            // let's create a random item for our inventory!
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
            
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
    // MARK: - Save objects via NSCoding
    // (works for any object that conforms to NSCoding)
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
        aCoder.encodeObject(serialNumber, forKey: "serialNumber")
        
        aCoder.encodeInteger(valueInDollars, forKey: "valueInDollars") // note .encodeInteger vs. .encodeObject
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
        serialNumber = aDecoder.decodeObjectForKey("serialNumber") as! String?
        
        valueInDollars = aDecoder.decodeIntegerForKey("")
        
        super.init()
    }
    
    
}
