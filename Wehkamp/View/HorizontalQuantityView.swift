//
//  HorizontalQuantityView.swift
//  Wehkamp
//
//  Created by Garaj on 26/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit
protocol HorizontalQuantityViewDelegate {
    func updateQuantity(quantity:Int,indexPath:IndexPath)
}

class HorizontalQuantityView: QuantityView {
    
    var delegate: HorizontalQuantityViewDelegate?
    
    fileprivate weak var quantityNibView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let quantityView = UINib.loadHQuantityView(self)
        self.addSubview(quantityView)
        self.quantityNibView = quantityView
    }
    
    func setQuantity(quantity:Int)
    {
        self.quantity = Dynamic.init(quantity)
        quantityLabel.text = NSNumber(integerLiteral: self.quantity.value).stringValue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        quantityNibView.frame = self.bounds
    }
    
    override func minusTap(sender: UIButton) {
        super.minusTap(sender: sender)
        self.quantityLabel.text = NSNumber(integerLiteral: quantity.value).stringValue
        delegate?.updateQuantity(quantity: getQuantity(), indexPath: IndexPath(row: tag, section: 0))
    }
    
    override func plusTap(sender: UIButton) {
        super.plusTap(sender: sender)
        self.quantityLabel.text = NSNumber(integerLiteral: quantity.value).stringValue
        delegate?.updateQuantity(quantity: getQuantity(), indexPath: IndexPath(row: tag, section: 0))
    }
}
