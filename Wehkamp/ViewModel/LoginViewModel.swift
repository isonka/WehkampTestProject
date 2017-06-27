//
//  LoginViewModel.swift
//  Wehkamp
//
//  Created by Garaj on 19/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

protocol LoginViewModelDelegate {
    func loggedIn()
    func loginFailed(errorMessage:String)
}

struct LoginViewModel
{
    
    var delegate : LoginViewModelDelegate?
    
    func login(username:String,password:String)
    {
        LoginHandler.login(username: username, password: password, success: {
         (response) in            
            guard let delegate = self.delegate else
            {
                fatalError("delegate must no be nil")
            }
            
            delegate.loggedIn()
            
        })
        {  (error) in
            
            guard let delegate = self.delegate else
            {
                fatalError("delegate must no be nil")
            }
            
            guard let errorMessage = error
                else
            {                
                delegate.loginFailed(errorMessage: Constants.ConnectionError)
                return
            }        
            delegate.loginFailed(errorMessage: errorMessage)
        }
    }
}
