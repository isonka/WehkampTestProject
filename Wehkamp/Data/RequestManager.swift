//
//  RequestManager.swift
//  Wehkamp
//
//  Created by Garaj on 19/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

import Alamofire

class RequestManager: NSObject {
    
    // Initializer
    
    static let sharedInstance = RequestManager()
    
    private var  networkReachabilityManager : NetworkReachabilityManager?
    private var  sessionManager : SessionManager?
    
    private override init(){
        super.init()
        
        networkReachabilityManager =  NetworkReachabilityManager()
        networkReachabilityManager?.listener = { status in
            print("Network Status Changed: \(status)")
            if status != .notReachable, status != .unknown
            {
                print("You are offline")
            }
        }
        networkReachabilityManager?.startListening()
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        sessionManager = SessionManager()
    }
    
    private func authorizationHeader() -> HTTPHeaders
    {
        var headers: HTTPHeaders = [:]
        
        guard let jwt = SingletonObject.sharedInstance.jwt else
        {
            return headers
        }
        
        headers["Authorization"] = "bearer \(jwt)"
        
        return headers;
    }
    
    //MARK: Http Actions
    
    func checkConnection() -> Bool
    {
        if networkReachabilityManager?.isReachable == false
        {
            return false
        }
        
        return true
    }
    
    func put(url:String,parameters:[String:Any],success: @escaping ([String:Any]?) -> Void ,failure: @escaping(String?) -> Void)
    {
        if checkConnection() == false
        {
            failure(Constants.ConnectionError)
            return
        }
        
        self.request(method: .put, url: url, parameters: parameters, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
    }
    
    func delete(url:String,success: @escaping (Bool?) -> Void ,failure: @escaping(String?) -> Void)
    {
        if checkConnection() == false
        {
            failure(Constants.ConnectionError)
            return
        }
        
        ThreadingHelper.scheduleBackground {
            self.sessionManager?.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default,headers:self.authorizationHeader())
                .responseJSON {
                    response in
                    switch response.result {
                    case .success(_):
                        success(true)
                        break
                    case .failure(let error):
                        failure(error.localizedDescription)
                    }
            }
        }
    }
    
    func get(url:String,success: @escaping ([String:Any]?) -> Void ,failure: @escaping(String?) -> Void)
    {
        if checkConnection() == false
        {
            failure(Constants.ConnectionError)
            return
        }
        
        self.request(method: .get, url: url, parameters: nil, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
    }
    
    func post(url:String,parameters:[String:Any],success: @escaping ([String:Any]?) -> Void ,failure: @escaping(String?) -> Void)
    {
        if checkConnection() == false
        {
            failure(Constants.ConnectionError)
            return
        }
        self.request(method: .post, url: url, parameters: parameters, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
    }
    
    func request(method:HTTPMethod,url:String,parameters:[String:Any]?,success: @escaping ([String:Any]?) -> Void ,failure: @escaping(String?) -> Void)
    {
        ThreadingHelper.scheduleBackground {
            self.sessionManager?.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default,headers:self.authorizationHeader())
                .responseJSON { [weak self] response in
                    
                    switch response.result {
                    case .success(let value):
                        guard let tempValue = value as? [String: Any] else
                        {
                            guard let tempArrayValue = value as? [Any] else
                            {
                                failure(Constants.ConnectionError)
                                return
                            }
                            
                            guard let tempArrayFirstObject = tempArrayValue[0] as? [String:Any] else
                            {
                                failure(Constants.ConnectionError)
                                return
                            }
                            
                            self?.genericResponseObjectParser(response: tempArrayFirstObject, success: { (responseParams) in
                                success(responseParams)
                            }, failure: { (errorMessage) in
                                failure(errorMessage)
                            })
                            
                            return
                        }
                        
                        self?.genericResponseObjectParser(response: tempValue, success: { (responseParams) in
                            success(responseParams)
                        }, failure: { (errorMessage) in
                            failure(errorMessage)
                        })
                    case .failure(let error):
                        failure(error.localizedDescription)
                    }
            }
        }
    }
    
    func genericResponseObjectParser(response:[String: Any]?,success: @escaping ([String:Any]?) -> Void,failure: @escaping(String?) -> Void) {
        
        guard let responseObject = response else {
            failure(Constants.ConnectionError)
            return
        }
        
        guard let failMessage = responseObject["message"] else {
            success(responseObject)
            return
        }
        
        failure(failMessage as? String)
    }
    
    //MARK:
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

