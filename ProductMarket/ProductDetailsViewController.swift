//
//  ProductDetailsViewController.swift
//  ProductMarket
//
//  Created by Jamal on 5/13/17.
//  Copyright © 2017 In10min. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var webView:UIWebView!
    
    var detailUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.detailUrl = "https://jobinja.ir"
        let url = NSURL(string: detailUrl)
        let request  = NSURLRequest(URL: url!)
        webView.loadRequest(request)

        setNavigationTitle()
        // Do any additional setup after loading the view.
    }

    func setNavigationTitle() {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        let titleLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 32))
        titleLabel.text = "مشخصات محصول"
        titleLabel.font = UIFont(name: "HelvaticaNeue-UltraLight", size: 30.0)
        self.navigationItem.titleView = titleLabel
    }
    
}
