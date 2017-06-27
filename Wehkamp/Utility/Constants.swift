//
//  Constants.swift
//  Touchwonders
//
//  Created by Garaj on 25/04/2017.
//  Copyright © 2017 garaj. All rights reserved.
//

import UIKit

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
}

struct DeviceType
{
    static let IsIpad              = UIDevice.current.userInterfaceIdiom == .pad
}

struct Constants {
    
    static let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    static let loadingController = Constants.mainStoryboard.instantiateViewController(withIdentifier: "LoadingStoryboardIdentifier")
    
    static let tabBarStoryboardIdentifier   = "ShopTabBarIdentifier"
    
    static let baseServiceUrl               = "https://app.wehkamp.nl/"
    
    static let basketChangedNotification    = Notification.Name.init("BasketChanged")
    
    static let tokenKey                     = "jwt"
    
    static let ConnectionError              = "Your are offline now. Please try again later"
    
    static let SharedAppDelegate            = UIApplication.shared.delegate as! AppDelegate
}

