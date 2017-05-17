//
//  CircleView.swift
//  ProductMarket
//
//  Created by Jamal on 5/12/17.
//  Copyright © 2017 In10min. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // backgroundColor = UIColor.brownColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor.whiteColor()
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
       // layer.cornerRadius = self.frame.height / 2
       // layer.masksToBounds = true
    }
    override func layoutSubviews() {
        updateSize()
    }
    func updateSize() {
        layer.cornerRadius = self.bounds.size.width / 2
    }
}
