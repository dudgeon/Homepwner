//
//  ImageStore.swift
//  Homepwner-Ch_09
//
//  Created by Geoffrey Dudgeon on 10/8/15.
//  Copyright © 2015 Geoff Dudgeon. All rights reserved.
//

import UIKit


class ImageStore {
    
    let cache = NSCache()
    
    func setImage(image: UIImage, forkey key: String) {
        cache.setObject(image, forKey: key)
        
        // create full url for image
        let imageURL = imageURLForKey(key)
        
        // turn image into JPEG data
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            
            // write the jpg to the url
            data.writeToURL(imageURL, atomically: true)
            
        }
    }
    
    func imageForKey(key: String) -> UIImage? {
        //return cache.objectForKey(key) as? UIImage
        
        if let existingImage = cache.objectForKey(key) as? UIImage {
            return existingImage
        }
        
        let imageUrl = imageURLForKey(key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageUrl.path!) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key)
        return imageFromDisk
    }
    
    
    func imageURLForKey(key: String) -> NSURL {
        let documentsDictionaries = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDictionaries.first!
        
        return documentDirectory.URLByAppendingPathComponent(key)
    }
    
    
    func deleteImageForKey(key: String) {
        cache.removeObjectForKey(key)
        
        let imageURL = imageURLForKey(key)
        do {
            try NSFileManager.defaultManager().removeItemAtPath(imageURL.path!)
        } catch let error {
            print("Error removing the image from disk: \(error)")
        }
    }
    
    
}
