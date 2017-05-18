//
//  RestApi.swift
//  ProductMarket
//
//  Created by Jamal on 5/9/17.
//  Copyright © 2017 In10min. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?)	-> Void

class RestApiManager {
    
    static let singletonInstance = RestApiManager()
    
    let compniesUrl = "http://localhost:5000/carvash/GetCompanies"
    let trendsUrl = "http://localhost:5000/api/trends"
    let showCasesUrl = "http://localhost:5000/api/ShowCases"
    let bestDealsUrl = "http://localhost:5000/api/BestDeals"
    let todayDealsUrl = "http://localhost:5000/api/TodayDeals"
    
    func loadCompanies(callBack: (JSON)-> Void){
        HttpRequest(compniesUrl, callBack: { json, error in
            callBack(json)
        })
    }
    
    
    func loadTrends(callBack: (JSON)-> Void){
        HttpRequest(trendsUrl, callBack: { json, error in
            callBack(json)
        })
    }
    
    func loadProducts(companyName:String, callBack:(JSON)-> Void)  {
        let url = "http://localhost:5000/api/products/\(companyName)/getProducts"
        HttpRequest(url, callBack: {
            json, error in
            callBack(json as JSON)
        })
    }
    
    
    func loadTrendProducts(trendId:String, callBack:(JSON)-> Void)  {
        let url = "http://localhost:5000/api/trends/\(trendId)/"
        HttpRequest(url, callBack: {
            json, error in
            callBack(json as JSON)
        })
    }
 
    func loadShowCases(callBack:(JSON)-> Void)  {
        
        HttpRequest(showCasesUrl, callBack: {
            json, error in
            callBack(json as JSON)
        })
    }
    
    func loadBestDeals(callBack:(JSON)-> Void)  {
        
        HttpRequest(bestDealsUrl, callBack: {
            json, error in
            callBack(json as JSON)
        })
    }
    
    func loadTodayDeals(callBack:(JSON)-> Void)  {
        
        HttpRequest(todayDealsUrl, callBack: {
            json, error in
            callBack(json as JSON)
        })
    }
    
    func findProducts(searchText:String, callBack:(JSON)-> Void)  {
        let url = "http://localhost:5000/api/search?searchText=/\(searchText)/"
        let escapedUrl = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        HttpRequest(escapedUrl!, callBack: {
            json, error in
            callBack(json as JSON)
        })
    }
    
    func HttpRequest(url: String, callBack: ServiceResponse ){
        
        let request = NSMutableURLRequest(URL:NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            let nsJson = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            let json = JSON(nsJson!) // Woohoo!! It works!!
            
            
            callBack(json, error)
//            
            
        })
        
        task.resume()
        
        
    }
}

