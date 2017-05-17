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
        
        let url = NSURL(string: detailUrl)
        let request  = NSURLRequest(URL: url!)
        webView.loadRequest(request)

        // Do any additional setup after loading the view.
    }

    
}
