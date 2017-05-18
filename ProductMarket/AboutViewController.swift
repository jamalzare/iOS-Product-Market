//
//  AboutViewController.swift
//  ProductMarket
//
//  Created by Jamal on 5/8/17.
//  Copyright © 2017 In10min. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
    }

    func setNavigationTitle() {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        let titleLabel : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 32))
        titleLabel.text = "درباره ما"
        titleLabel.font = UIFont(name: "HelvaticaNeue-UltraLight", size: 30.0)
        self.navigationItem.titleView = titleLabel
    }
}
