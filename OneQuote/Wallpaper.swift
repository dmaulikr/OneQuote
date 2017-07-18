//
//  Wallpaper.swift
//  OneQuote
//
//  Created by Ryan Phan on 7/18/17.
//  Copyright © 2017 Ryan Phan. All rights reserved.
//

import Foundation

import UIKit

class Wallpaper {
    var wallpapers = [String]()
    init() {
        FlickerClient.searchForWallpaper { (data) in
            print(data)
            self.wallpapers = data
        }
    }
    
    func getRandomPicURL() -> String {
        
        let count = UInt32((wallpapers.count))
        let num = Int(arc4random_uniform(count))
        return wallpapers[num]
    }
    
    
    
}
