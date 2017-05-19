    //
    //  TrendsViewController.swift
    //  ProductMarket
    //
    //  Created by Jamal on 5/8/17.
    //  Copyright © 2017 In10min. All rights reserved.
    //
    
    import UIKit
    
    class TrendsViewController: UIViewController, UITableViewDataSource {
        
        
        @IBOutlet weak var trendTableView: UITableView!
        
        var trends = [Trend]()
        override func viewDidLoad() {
            super.viewDidLoad()
            // translatesAutoresizingMaskIntoConstraints = true
            
            loadTrends()
        }
        
        func setNavigationTitle() {
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
            let titleLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 32))
            titleLabel.text = "مجموعه ها"
            titleLabel.font = UIFont(name: "HelvaticaNeue-UltraLight", size: 30.0)
            self.navigationItem.titleView = titleLabel
        }
        
        func loadTrends()  {
            RestApiManager.singletonInstance.loadTrends{
                json in
                
                for(_, item) in json {
                    let name = item["name"].string!
                    let imageUrl = item["imageUrl"].string!
                    let collectionId = item["collectionID"].int!
                    
                    let trend = Trend(name: name, collectionId: collectionId, imageUrl: imageUrl)
                    
                    self.trends.append(trend)
                }
                dispatch_async(dispatch_get_main_queue()){
                    self.trendTableView.reloadData()
                }
                
            }
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return trends.count
        }
        
        internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("TrendCell", forIndexPath: indexPath) as! TrendTableViewCell
            
            let trend = self.trends[indexPath.row]
            if let url = NSURL(string: trend.imageUrl){
                
                if let data = NSData(contentsOfURL: url){
                    cell.trendImageView.image = UIImage(data: data)
                }
            }
            cell.trendNameLabel?.text = trend.name!
            print(cell.trendNameLabel?.text)
            return cell
        }
        
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "ShowTrendProducts"{
                
                if let cell = sender as? TrendTableViewCell{
                    
                    let index = trendTableView.indexPathForCell(cell)
                    
                    if let destinationVC = segue.destinationViewController as? TrendProdctsViewController {
                        
                        destinationVC.trendId = self.trends[index!.row].collectionId
                    }
                }
            }
        }
    }
