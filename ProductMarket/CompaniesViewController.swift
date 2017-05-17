//
//  CompaniesViewController.swift
//  ProductMarket
//
//  Created by Jamal on 5/8/17.
//  Copyright © 2017 In10min. All rights reserved.
//

import UIKit

class CompaniesViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var companyCollectionView: UICollectionView!
    
    private var companies = [Company]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStores()
    }
    
    func loadStores() {
        print("uhdf dfg hrtr here")
        RestApiManager.singletonInstance.loadCompanies{json in
            
            
            
            let data = json
            
            for(_, item) in data{
                
                let company = Company(name: item["name"].string!, totalProductCount: item["productCount"].int!)
                
                self.companies.append(company)
                
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.companyCollectionView.reloadData()
            })
            
        }
    }
    
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return companies.count
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCompanyCell
        cell.arm.image = UIImage(named: companies[indexPath.row].name )
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let totalWidth: CGFloat = self.view.frame.size.width/2
        let totalHeight: CGFloat = self.view.frame.size.width/2
        
        return CGSize(width: totalWidth - 20, height: totalHeight - 20)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowProducts"{
            
            if let cell = sender as? CustomCompanyCell{
                let index = companyCollectionView.indexPathForCell(cell)
                if let destinactionVC = segue.destinationViewController as? CompanyProductsViewController{
                    destinactionVC.companyName = self.companies[index!.row].name
                }
            }
        }
    }
    
    
}
