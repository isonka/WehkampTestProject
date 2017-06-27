//
//  LoginHandler.swift
//  Wehkamp
//
//  Created by Garaj on 19/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

struct LoginHandler {
    static func login(username:String,password:String,success: @escaping (LoginResponseModel?) -> Void,failure: @escaping (String?) -> Void)
    {
        let loginApiUrl = "\(Constants.baseServiceUrl)authentication/api"
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        RequestManager.sharedInstance.post(url: loginApiUrl, parameters: parameters, success: { (loginResponse) in
            guard let response = loginResponse
                else
            {
                success(nil)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                
                let loginResponseModel = try decoder.decode(LoginResponseModel.self, from: jsonData)
                
                guard let jwt = loginResponseModel.jwt else
                {
                    success(nil)
                    return
                }
                
                SingletonObject.sharedInstance.jwt = jwt
                
                BasketHandler.getBasket(success: { (basketResponse) in
                    success(loginResponseModel)
                }, failure: { (error) in
                    failure(error)
                })                
            } catch {
                print("error trying to convert data to JSON")
                success(nil)
                return
            }
            
        }) { (errorMessage) in
            failure(errorMessage)
        }
    }
}
