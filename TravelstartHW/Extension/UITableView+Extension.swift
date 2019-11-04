//
//  UITableView+Extension.swift
//  TravelstartHW
//
//  Created by ting hui wu on 2019/11/4.
//  Copyright © 2019 ting hui wu. All rights reserved.
//

import UIKit

extension UITableView {

    func TS_registerCellWithNib(identifier: String, bundle: Bundle?) {

        let nib = UINib(nibName: identifier, bundle: bundle)

        register(nib, forCellReuseIdentifier: identifier)
    }

    func TS_registerHeaderWithNib(identifier: String, bundle: Bundle?) {

        let nib = UINib(nibName: identifier, bundle: bundle)

        register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

extension UITableViewCell {
    
    static var identifier: String {
        
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    
    static var identifier: String {
        
        return String(describing: self)
    }
}
