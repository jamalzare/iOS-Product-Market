//
//  Trend.swift
//  ProductMarket
//
//  Created by Jamal on 5/14/17.
//  Copyright © 2017 In10min. All rights reserved.
//

import Foundation

class Trend {
    var name: String!
    var collectionId: Int!
    var imageUrl: String!
    
    
    init(name: String, collectionId: Int, imageUrl: String ){
        self.name = name
        self.collectionId = collectionId
        self.imageUrl = imageUrl
    }
}
