//
//  ColorWheel.swift
//  Fun Fact
//
//  Created by Ryan Phan on 2/19/16.
//  Copyright © 2016 Ryan Phan. All rights reserved.
//

import Foundation
import UIKit

struct ColorWheel {
    let colorsArray = [
        UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0), //teal color
        UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), //yellow color
        UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0), //red color
        UIColor(red: 239/255.0, green: 130/255.0, blue: 100/255.0, alpha: 1.0), //orange color
        UIColor(red: 77/255.0, green: 75/255.0, blue: 82/255.0, alpha: 1.0), //dark color
        UIColor(red: 105/255.0, green: 94/255.0, blue: 133/255.0, alpha: 1.0), //purple color
        UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0), //green color
        UIColor(red: 51/255.0, green: 153/255.0, blue: 255/255.0, alpha: 1.0),
        UIColor(red: 224/255.0, green: 5/255.0, blue: 250/255.0, alpha: 1.0),
        UIColor(red: 250/255.0, green: 5/255.0, blue: 9/255.0, alpha: 1.0),
        UIColor(red: 250/255.0, green: 72/255.0, blue: 5/255.0, alpha: 1.0),
        UIColor(red: 113/255.0, green: 250/255.0, blue: 5/255.0, alpha: 1.0),
        UIColor(red: 5/255.0, green: 250/255.0, blue: 127/255.0, alpha: 1.0)
        
    ]
    
    func getRandomColor() -> UIColor {
        let count = UInt32(colorsArray.count)
        let num = Int(arc4random_uniform(count))
        return colorsArray[num]
    }

}
