//
//  TrendProdctsViewController.swift
//  ProductMarket
//
//  Created by Jamal on 5/16/17.
//  Copyright © 2017 In10min. All rights reserved.
//

import UIKit

class TrendProdctsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var productsCollectionView: UICollectionView!

    var products = [TrendProduct]()
    var trendId : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProducts()
    }
    
    func loadProducts()  {
        
        self.trendId = 1
        RestApiManager.singletonInstance.loadTrendProducts(self.trendId,callBack: {json in
            
            for(_, item) in json {
                let name = item["name"].string!
//                let oldPrice = item["oldPrice"].double!
                let newPrice = item["newPrice"].double!
                let imageUrl = item["imageUrl"].string!
                let detailUrl = item["detailUrl"].string!
                
                let product = TrendProduct (name: name, oldPrice: 23, newPrice: newPrice, imageUrl: imageUrl, detailUrl: detailUrl)
                
                self.products.append(product)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.productsCollectionView.reloadData()
            })
            
            
        })
    }
    
    
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return products.count
    }
    
    
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TrendProductCollectionViewCell
        
        let product = self.products[indexPath.row]
        
        if let url = NSURL(string: product.imageUrl){
            
            if let data = NSData(contentsOfURL: url){
                cell.productImageView.image = UIImage(data: data)
            }
        }
        
        
        cell.productNameLabel.text = product.name
        cell.newPriceLabel.text = String(format: "%.2f", product.newPrice)
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        let totalWidth: CGFloat = self.view.frame.size.width/2
        let totalHeight: CGFloat = self.view.frame.size.width/2
        
        return CGSize(width: totalWidth - 20, height: totalHeight - 20)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowProductDetail"{
            
            if let cell = sender as? TrendProductCollectionViewCell{
                let index = productsCollectionView.indexPathForCell(cell)
                if let destinactionVC = segue.destinationViewController as? ProductDetailsViewController{
                    destinactionVC.detailUrl = self.products[index!.row].detailUrl!
                }
            }
        }
    }
   
    
}
