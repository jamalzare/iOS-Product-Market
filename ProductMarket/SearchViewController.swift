//
//  SearchViewController.swift
//  ProductMarket
//
//  Created by Jamal on 5/8/17.
//  Copyright © 2017 In10min. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var productsTableView: UITableView!
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        findProducts(searchText)
    }
    
    func findProducts(searchText: String){
        
        products = [Product]()
        
        if(searchText == ""){
            productsTableView.reloadData()
            return
        }
        
        RestApiManager.singletonInstance.findProducts(searchText, callBack:{
            json in
            
            for(_, item) in json {
                let name = item["name"].string!
                let oldPrice = item["oldPrice"].double!
                let newPrice = item["newPrice"].double!
                let imageUrl = item["imageUrl"].string!
                let detailUrl = item["detailUrl"].string!
                
                let product = Product(name: name, oldPrice: oldPrice, newPrice: newPrice, imageUrl: imageUrl, detailUrl: detailUrl)
                
                self.products.append(product)
            }
            dispatch_async(dispatch_get_main_queue()){
                self.productsTableView.reloadData()
            }
        })
    }
    
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return products.count
    }
    
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CompanyProductCell
        
        let product = self.products[indexPath.row]
        
        if let url = NSURL(string: product.imageUrl){
            
            if let data = NSData(contentsOfURL: url){
                cell.productImageView.image = UIImage(data: data)
            }
        }
        
        cell.productNameLabel.text = product.name
        cell.oldPriceLabel.text = String(format: "%.2f", product.oldPrice)
        cell.newPriceLabel.text = String(format: "%.2f", product.newPrice)
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail"{
            
            if let cell = sender as? CompanyProductCell{
                let index = productsTableView.indexPathForCell(cell)
                if let destinactionVC = segue.destinationViewController as? ProductDetailsViewController{
                    destinactionVC.detailUrl = self.products[index!.row].detailUrl
                }
            }
        }
    }
    
    
}
