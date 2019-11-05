//
//  TouristCollectionViewCell.swift
//  TravelstartHW
//
//  Created by ting hui wu on 2019/11/5.
//  Copyright © 2019 ting hui wu. All rights reserved.
//

import UIKit

class TouristCollectionViewCell: UICollectionViewCell {
    
    var imageView:UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0),
        size: self.frame.size)
        
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
