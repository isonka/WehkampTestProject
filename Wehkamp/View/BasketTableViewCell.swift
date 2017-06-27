//
//  BasketTableViewCell.swift
//  Wehkamp
//
//  Created by Garaj on 25/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityView: HorizontalQuantityView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceLabel.adjustsFontSizeToFitWidth = true
        
        if DeviceType.IsIpad
        {
            nameWidthConstraint.constant = 350
        }
    }
}
