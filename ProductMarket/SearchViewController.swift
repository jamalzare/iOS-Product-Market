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
        self.productsTableView.tableFooterView = UIView()
        setNavigationTitle()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        findProducts(searchText)
    }
    
    func setNavigationTitle() {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        let titleLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 32))
        titleLabel.text = "جستجوی محصول"
        titleLabel.font = UIFont(name: "HelvaticaNeue-UltraLight", size: 30.0)
        self.navigationItem.titleView = titleLabel
    }
    
    func findProducts(searchText: String){
        
        products = [Product]()
        productsTableView.reloadData()
        if(searchText == ""){
            
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
//        cell.oldPriceLabel.text = String(format: "%.2f", product.oldPrice)
        cell.newPriceLabel.text = String(format: "%.2f", product.newPrice)
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowProductDetail"{
            
            if let cell = sender as? CompanyProductCell{
                let index = productsTableView.indexPathForCell(cell)
                if let destinactionVC = segue.destinationViewController as? ProductDetailsViewController{
                    destinactionVC.detailUrl = self.products[index!.row].detailUrl
                }
            }
        }
    }
    
    
}
