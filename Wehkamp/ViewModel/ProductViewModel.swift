//
//  ProductViewModel.swift
//  Wehkamp
//
//  Created by Garaj on 20/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import Foundation
import UIKit

protocol ProductViewModelDelegate {
    func productAddedToBasket()
    func errorOccured(error:String?)
}

class ProductViewModel:NSObject {
    
    var delegate : ProductViewModelDelegate?
    
    fileprivate var products : Dynamic<[ProductModel]>
    
    override init() {
        
        self.products = Dynamic.init([ProductModel]())
        
        guard let path = Bundle.main.path(forResource: "products", ofType: "json")
            else{
                return
        }
        do
        {
            var jsonData =  try Data.init(contentsOf: URL(fileURLWithPath: path))
            let jsonString = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [String:Any]
            guard let productsDictionary = jsonString["Products"] else
            {
                return
            }
            
            jsonData = try JSONSerialization.data(withJSONObject: productsDictionary, options: .prettyPrinted)
            
            let decoder = JSONDecoder()
            do {
                self.products = try Dynamic.init(decoder.decode([ProductModel].self, from: jsonData))
            }
            catch {
                fatalError("json file is unreachable")
            }
        }
        catch
        {
            
        }
    }
    
    func numberOfItems()->Int
    {
        return products.value.count
    }
    
    func getDisplayedValuesAt(indexPath:IndexPath) -> (name:String,price:String,actionLabel:String,stracthPrice:NSMutableAttributedString,actionLabelBackgroundColor:UIColor)
    {
        let product = productAt(indexPath: indexPath)
        return (nameOf(product: product),priceOf(product: product),actionLabelOf(product: product),scratchPriceOf(product: product),actionLabelBackgroundColorOf(product:product))
    }
    
    private func nameOf(product:ProductModel) -> String
    {
        guard let name = product.Name else
        {
            return ""
        }
        
        return name
    }
    
    private func scratchPriceOf(product:ProductModel) -> NSMutableAttributedString
    {
        guard let scratchPrice = product.ScratchPrice else
        {
            return NSMutableAttributedString()
        }
        
        if scratchPrice == product.Price
        {
            return NSMutableAttributedString()
        }
        
        let price = Formatter.numberFormatter.string(from: NSNumber(value: scratchPrice))!
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: price)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    private func priceOf(product:ProductModel) -> String
    {
        guard let price = product.Price else
        {
            return ""
        }
        
        return Formatter.numberFormatter.string(from: NSNumber(value: price))!
    }
    
    func actionLabelOf(product:ProductModel) -> String
    {
        guard let actionLabel = product.ActionLabel else
        {
            return ""
        }
        return actionLabel
    }
    
    func actionLabelBackgroundColorOf(product:ProductModel) -> UIColor
    {
        guard let actionLabelBackgroundColor = product.ActionLabelBackgroundColor else
        {
            return UIColor.clear
        }
        
        return UIColor.init(hexString: actionLabelBackgroundColor)
    }
    
    private func productAt(indexPath:IndexPath) -> ProductModel
    {
        if products.value.count > indexPath.row {
            
            return products.value[indexPath.row]
        }
        
        return ProductModel()
    }
    
    //MARK: Data Handlers
    
    func addProductToBasket(indexPath: IndexPath, quantity: Int) {
        let product = productAt(indexPath: indexPath)
        BasketHandler.addProductToBasket(product: product, quantity: quantity, success: { (response) in
            guard let delegate = self.delegate else
            {
                return
            }
            
            delegate.productAddedToBasket()
        }) { (error) in
            guard let delegate = self.delegate else
            {
                return
            }
            
            delegate.errorOccured(error: error)
        }
    }
    
    func sortProductsForCampaign()
    {
        products.value = products.value.sorted { (obj1, obj2) -> Bool in
            guard let isInCampaign = obj1.IsInCampaign else
            {
                return false
            }
            if isInCampaign
            {
                return true
            }
            
            return false
        }
    }
}
