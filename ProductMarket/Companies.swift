//
//  Store.swift
//  ProductMarket
//
//  Created by Jamal on 5/9/17.
//  Copyright © 2017 In10min. All rights reserved.
//

import Foundation

class Company{
    var name: String!
    var totalProductCount: Int!
    
    init(name: String, totalProductCount: Int){
        self.name = name
        self.totalProductCount = totalProductCount
    }
}