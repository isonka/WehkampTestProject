//
//  BasketHandler.swift
//  Wehkamp
//
//  Created by Garaj on 20/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

struct BasketHandler {
    
    static func updateProductFromBasket(id:String,quantity:Int,success: @escaping (BasketItemModel?) -> Void,failure: @escaping (String?) -> Void)
    {
        let basketApiUrl = "\(Constants.baseServiceUrl)service/basket/basket/items/\(id)"
        
        let parameters = ["number_of_items":quantity]
        
        RequestManager.sharedInstance.put(url: basketApiUrl,parameters: parameters, success: { (basketResponse) in
            guard let response = basketResponse
                else
            {
                success(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let basketItemModel = try decoder.decode(BasketItemModel.self, from: jsonData)
                success(basketItemModel)
            }
            catch {
                print(error)
                success(nil)
                return
            }
            
        }) { (error) in
            failure(error)
        }
    }
    
    static func deleteProductFromBasket(basketItem:BasketItemModel,success: @escaping (Bool) -> Void,failure: @escaping (String?) -> Void)
    {
        let basketApiUrl = "\(Constants.baseServiceUrl)service/basket/basket/items/\(basketItem.id ?? "")"
        
        RequestManager.sharedInstance.delete(url: basketApiUrl, success: { (basketResponse) in
            guard let _ = basketResponse
                else
            {
                success(false)
                return
            }
            
            getBasket(success: { (basketResponse) in
                success(true)
            }, failure: { (error) in
                
            })
            
        }) { (error) in
            
        }
    }
    
    static func addProductToBasket(product:ProductModel,quantity:Int,success: @escaping (Bool) -> Void,failure: @escaping (String?) -> Void)
    {
        let basketApiUrl = "\(Constants.baseServiceUrl)service/basket/basket/items/"
        
        let parameters: [String: Any] = [
            "items":[["product_number": product.Number ?? "",
                      "number_of_products": quantity,
                      "size_code": "000"]]
        ]
        
        RequestManager.sharedInstance.post(url: basketApiUrl, parameters: parameters, success: { (basketResponse) in
            
            guard let _ = basketResponse
                else
            {
                success(false)
                return
            }
            
            getBasket(success: { (basketResponse) in
                success(true)
            }, failure: { (error) in
                success(true)
            })
            
        }) { (error) in
            failure(error)
        }
    }
    
    static func getBasket(success: @escaping (BasketResponseModel?) -> Void,failure: @escaping (String?) -> Void)
    {
        let basketApiUrl = "\(Constants.baseServiceUrl)service/basket/basket"
        
        RequestManager.sharedInstance.get(url: basketApiUrl, success: { (basketResponse) in
            
            guard let response = basketResponse
                else
            {
                success(nil)
                return
            }
            
            let basketResponseModel = BasketResponseModel(json: response)
            
            SingletonObject.sharedInstance.updateBasket(basketResponse: basketResponseModel)
            
            success(basketResponseModel)
            
        }) { (error) in
            
        }                
    }    
}
