//
//  HomeViewController.swift
//  ProductMarket
//
//  Created by Jamal on 5/8/17.
//  Copyright © 2017 In10min. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController, iCarouselDataSource, UICollectionViewDataSource {
    
    // @IBOutlet weak var bannerViwe: GADBannerView!
    @IBOutlet weak var carousel: iCarousel!
    
    @IBOutlet weak var bestDealsCollectionView: UICollectionView!
    
    @IBOutlet weak var todayDealsCollectionView: UICollectionView!
    
    var bestDeals = [Product]()
    var todayDeals = [Product]()
    
    
    
    var showCases = [Trend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadShowCases()
        loadBestDeals()
        loadTodayDeals()
        
        setNavigationTitle()
        
        //loadBannerView()
    }
    
    func setNavigationTitle() {
      
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        let titleLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 32))
        titleLabel.text = "P r o d u c t  M a r k e t"
        titleLabel.font = UIFont(name: "HelvaticaNeue-UltraLight", size: 30.0)
        self.navigationItem.titleView = titleLabel
        
       
        
    }
    
    func loadBannerView() {
//        self.bannerViwe.adUnitID = "ca-app-pub-3940256099942544~1458002511"
//        bannerViwe.rootViewController = self
//        var request:GADRequest = GADRequest()
//        bannerViwe.loadRequest(request)
    }
    
    func loadShowCases()  {
        
        RestApiManager.singletonInstance.loadShowCases{
            json in
            
            for(_, item) in json {
                let name = item["name"].string!
                let imageUrl = item["imageUrl"].string!
                let collectionId = item["collectionID"].int!
                
                let trend = Trend(name: name, collectionId: collectionId, imageUrl: imageUrl)
                
                self.showCases.append(trend)
            }
            
            dispatch_async(dispatch_get_main_queue()){
                self.carousel.reloadData()
            }
        }
    }
    
    func loadBestDeals()  {
        
        RestApiManager.singletonInstance.loadBestDeals{
            json in
            
            for(_, item) in json {
                let name = item["name"].string!
                let oldPrice = item["oldPrice"].double!
                let newPrice = item["newPrice"].double!
                let imageUrl = item["imageUrl"].string!
                let detailUrl = item["detailUrl"].string!
                
                let product = Product(name: name, oldPrice: oldPrice, newPrice: newPrice, imageUrl: imageUrl, detailUrl: detailUrl)
                
                self.bestDeals.append(product)
            }
            
            dispatch_async(dispatch_get_main_queue()){
                self.bestDealsCollectionView.reloadData()
            }
        }
    }
    
    func loadTodayDeals()  {
        
        RestApiManager.singletonInstance.loadTodayDeals{
            json in
            
            for(_, item) in json {
                let name = item["name"].string!
                let oldPrice = item["oldPrice"].double!
                let newPrice = item["newPrice"].double!
                let imageUrl = item["imageUrl"].string!
                let detailUrl = item["detailUrl"].string!
                
                let product = Product(name: name, oldPrice: oldPrice, newPrice: newPrice, imageUrl: imageUrl, detailUrl: detailUrl)
                
                self.todayDeals.append(product)
            }
            
            dispatch_async(dispatch_get_main_queue()){
                self.todayDealsCollectionView.reloadData()
            }
        }
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return showCases.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        
        var label: UILabel
        var itemView: UIImageView
        
       
        
        if(view == nil){
            
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 50, height: 150))
            
            itemView.layer.cornerRadius = 10
            itemView.layer.masksToBounds = true
            
            if let url = NSURL(string: showCases[index].imageUrl){
                if let data = NSData(contentsOfURL: url){
                    itemView.contentMode = UIViewContentMode.ScaleAspectFill
                    itemView.image = UIImage(data: data)
                }
            }
            
            label = UILabel(frame: itemView.bounds)
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = .Center
            label.font  = label.font.fontWithSize(30)
            label.tag = 1
            label.numberOfLines = 2
            label.shadowColor = UIColor.whiteColor()
            label.shadowOffset = CGSizeMake(2, 2)
            
            itemView.addSubview(label)
            
        }
        else{
            itemView = view as! UIImageView
            
            if let url = NSURL(string: showCases[index].imageUrl){
                if let data = NSData(contentsOfURL: url){
                    itemView.contentMode = UIViewContentMode.ScaleAspectFill
                    itemView.image = UIImage(data: data)
                }
            }
            
            label = itemView.viewWithTag(1) as! UILabel
        }
        
        label.text = "\(showCases[index].name)"
        
        return itemView
    }
    
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if(collectionView.tag == 1){
            return bestDeals.count
        }else if(collectionView.tag == 2){
            return todayDeals.count
        }
        return 0
    }
    
    
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var product:Product!
        if(collectionView.tag == 1)
        {
            product = self.bestDeals[indexPath.row]
        }
        
        if(collectionView.tag == 2)
        {
            product = self.todayDeals[indexPath.row]
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ProductCell
        
        
        
        if let url = NSURL(string: product.imageUrl){
            
            if let data = NSData(contentsOfURL: url){
                cell.productImagView.image = UIImage(data: data)
            }
        }
        
        
        cell.productPriceLabel.text = String(format: "%.2f", product.newPrice)
        
        cell.ProductNameLabel.text = product.name
        
        return cell
    }
    
}
