//
//  TouristTableViewCell.swift
//  TravelstartHW
//
//  Created by ting hui wu on 2019/11/4.
//  Copyright © 2019 ting hui wu. All rights reserved.
//

import UIKit

class TouristTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptLabel: UILabel!
    
    var indexPathInCode: IndexPath?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
