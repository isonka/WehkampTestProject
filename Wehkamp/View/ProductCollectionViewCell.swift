//
//  ProductCollectionViewCell.swift
//  Wehkamp
//
//  Created by Garaj on 21/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

protocol ProductCellDelegate {
    func addProductToBasket(indexPath:IndexPath,quantity:Int)
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    var delegate : ProductCellDelegate?
    
    var indexPath: IndexPath = []
    
    @IBOutlet weak var quantityView: QuantityView!
    @IBOutlet weak var sendToBasketButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var scratchPriceLabel: UILabel!
    @IBOutlet weak var actionLabel: WHKLabel!
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sendToBasketButton.titleLabel?.numberOfLines = 0
        sendToBasketButton.titleLabel?.textAlignment = .center                
    }
    
    @IBAction func sendToBasketTap(sender:UIButton)
    {
        let quantity = quantityView.getQuantity()
        
        guard let delegate = delegate else
        {
            fatalError()
        }
        delegate.addProductToBasket(indexPath: indexPath, quantity: quantity)        
    }
}
