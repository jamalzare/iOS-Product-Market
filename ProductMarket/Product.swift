//
//  Product.swift
//  ProductMarket
//
//  Created by Jamal on 5/11/17.
//  Copyright © 2017 In10min. All rights reserved.
//

import Foundation

class Product {
    
    var name:String!
    var oldPrice:Double!
    var newPrice:Double!
    var imageUrl:String!
    var detailUrl: String!
    
    init(name: String, oldPrice:Double, newPrice:Double, imageUrl:String, detailUrl:String){
        
        self.name = name
        self.oldPrice = oldPrice
        self.newPrice = newPrice
        self.imageUrl = imageUrl
        self.detailUrl = detailUrl
        
    }
}