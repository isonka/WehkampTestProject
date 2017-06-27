//
//  SingletonObject.swift
//  Wehkamp
//
//  Created by Garaj on 20/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

class SingletonObject: NSObject {
    
    var basketResponse : BasketResponseModel?
    var jwt : String?
    
    static let sharedInstance : SingletonObject = {
        let instance = SingletonObject()
        return instance
    }()
    
    func replaceBasketItemAt(index:Int,basketItem:BasketItemModel)
    {
        basketResponse?.basket_items?[index] = basketItem
        
        let numberSum = basketResponse!.basket_items!.map({$0.total_price}).reduce(0, { x, y in x + (y ?? Double(exactly: 0)!) })
        basketResponse?.total = numberSum
        
        NotificationCenter.default.post(name: Constants.basketChangedNotification, object: nil)
    }
    
    func updateBasket(basketResponse:BasketResponseModel?)
    {
        self.basketResponse = basketResponse
        NotificationCenter.default.post(name: Constants.basketChangedNotification, object: nil)
    }
}
