//
//  UIHelper.swift
//  Wehkamp
//
//  Created by Garaj on 20/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//


import UIKit

struct UIHelper {
    
    static func presentViewController(controller:UIViewController)
    {
        ThreadingHelper.scheduleMain {
            (Constants.SharedAppDelegate.window?.rootViewController as! UINavigationController).visibleViewController?.present(controller, animated: true, completion: nil)
        }
    }
    
    static func showLoader()
    {
        ThreadingHelper.scheduleMain {
            Constants.SharedAppDelegate.loadingWindow.isHidden = false
        }
    }
    
    static func hideLoader()
    {
        ThreadingHelper.scheduleMain {
            Constants.SharedAppDelegate.loadingWindow.isHidden = true
        }
    }
    
    static func retrieveDefaults(key:String) -> Any?
    {
        if key.characters.count > 0
        {
            return UserDefaults.standard.value(forKey: key)
        }
        
        return nil
    }
    
    static func saveDefault(key:String,object:Any?)
    {
        if key.characters.count > 0 && object != nil
        {
            UserDefaults.standard.set(object, forKey: key)
        }
    }
    
    static func removeDefault(key:String)
    {
        if key.characters.count > 0
        {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
}

