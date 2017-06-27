//
//  QuantityView.swift
//  Wehkamp
//
//  Created by Garaj on 22/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

enum QuantityAction: Int {
    case minus = 0
    case plus = 1
}

class QuantityView: UIView {
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    fileprivate weak var quantityNibView: UIView!
    
    let maximumQuantity = 9
    var quantity = Dynamic.init(1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let quantityView = UINib.loadQuantityView(self)
        self.addSubview(quantityView)
        self.quantityNibView = quantityView
        
        quantity.bind { [weak self] (response) in
            self?.quantityLabel.text = NSNumber(integerLiteral: response).stringValue
        }        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        quantityNibView.frame = self.bounds
    }
    
    func getQuantity() -> Int
    {
        return quantity.value
    }
    
    @IBAction func minusTap(sender:UIButton)
    {
        if canQuantityChange(actionType: .minus)
        {
            quantity.value = quantity.value - 1
        }
    }
    
    @IBAction func plusTap(sender:UIButton)
    {
        if canQuantityChange(actionType: .plus)
        {
            quantity.value = quantity.value + 1
        }
    }
    
    private func canQuantityChange(actionType: QuantityAction ) -> Bool
    {
        if actionType == .minus, quantity.value == 1
        {
            return false
        }
        else if actionType == .plus, quantity.value == maximumQuantity
        {
            return false
        }
        return true
    }
}
