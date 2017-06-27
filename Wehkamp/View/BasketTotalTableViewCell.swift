//
//  BasketTotalTableViewCell.swift
//  Wehkamp
//
//  Created by Garaj on 25/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

class BasketTotalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceLabel.adjustsFontSizeToFitWidth = true
    }
}
