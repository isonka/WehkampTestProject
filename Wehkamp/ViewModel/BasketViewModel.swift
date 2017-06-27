//
//  BasketViewModel.swift
//  Wehkamp
//
//  Created by Garaj on 25/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import Foundation

protocol BasketViewModelDelegate {
    func errorOccured(message:String?)
}

struct BasketViewModel
{
    var delegate: BasketViewModelDelegate?
    
    //MARK: Data Handlers
    
    func deleteItemAt(indexPath:IndexPath)
    {
        let basketItem = basketItemAt(indexPath: indexPath)
        
        BasketHandler.deleteProductFromBasket(basketItem:basketItem , success: {
            (response) in
            
        }) { (error) in
            guard let delegate = self.delegate else
            {
                fatalError("delegate must no be nil")
            }
            
            delegate.errorOccured(message: error)
        }
    }
    
    func updateQuantityAt(indexPath:IndexPath,quantity:Int)
    {
        let basketItem = basketItemAt(indexPath: indexPath)
        
        BasketHandler.updateProductFromBasket(id: basketItem.id ?? "", quantity: quantity, success: { (response) in
            guard let basketItem = response else
            {
                return
            }
            
            SingletonObject.sharedInstance.replaceBasketItemAt(index: indexPath.row, basketItem: basketItem)
            
        }) { (error) in
            guard let delegate = self.delegate else
            {
                fatalError("delegate must no be nil")
            }
            
            delegate.errorOccured(message: error)
        }
    }
    
    // Visual Objects
    
    func numberOfItems()->Int
    {
        guard let numberOfItems = SingletonObject.sharedInstance.basketResponse?.basket_items?.count else
        {
            return 0
        }
        
        if numberOfItems == 0
        {
            return numberOfItems
        }
        
        return numberOfItems + 1
    }
    
    func basketTotalPrice() -> String
    {
        guard let totalPrice = SingletonObject.sharedInstance.basketResponse?.total else
        {
            return ""
        }
        
        guard let totalPriceAsString = Formatter.numberFormatter.string(from: NSNumber(value:totalPrice)) else
        {
            return ""
        }
        
        return totalPriceAsString
    }
    
    func getDisplayedValuesAt(indexPath:IndexPath) -> (name:String,price:String,quantity:Int)
    {
        let basketItem = basketItemAt(indexPath: indexPath)
        return (nameOf(basketItem: basketItem),priceOf(basketItem: basketItem),quantityOf(basketItem: basketItem))
    }
    
    private func quantityOf(basketItem:BasketItemModel) -> Int
    {
        guard let quantity = basketItem.number_of_products else
        {
            return 0
        }
        
        return Int(quantity)
    }
    
    private func nameOf(basketItem:BasketItemModel) -> String
    {
        guard let name = basketItem.normalized_name else
        {
            return ""
        }
        
        return name
    }
    
    private func priceOf(basketItem:BasketItemModel) -> String
    {
        guard let totalPrice = basketItem.total_price else
        {
            return ""
        }
        
        guard let totalPriceAsString = Formatter.numberFormatter.string(from: NSNumber(value:totalPrice)) else
        {
            return ""
        }
        
        return totalPriceAsString
    }
    
    private func basketItemAt(indexPath:IndexPath) -> BasketItemModel
    {
        guard let basket = SingletonObject.sharedInstance.basketResponse?.basket_items else
        {
            return BasketItemModel()
        }
        
        if basket.count > indexPath.row {
            
            return basket[indexPath.row]
        }
        
        return BasketItemModel()
    }
}
