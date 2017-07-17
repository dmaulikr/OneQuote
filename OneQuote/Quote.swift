//
//  Quote.swift
//  OneQuote
//
//  Created by Ryan Phan on 7/16/17.
//  Copyright © 2017 Ryan Phan. All rights reserved.
//

import CoreData
class Quote: NSManagedObject {
    convenience init(context: NSManagedObjectContext, author: String, id: String, quote: String) {
        self.init(context: context)
        self.author = author
        self.id = id
        self.quote = quote
    }
}
