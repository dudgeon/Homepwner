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
    }
    
    func imageForKey(key: String) -> UIImage? {
        return cache.objectForKey(key) as? UIImage
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObjectForKey(key)
    }
    
}
