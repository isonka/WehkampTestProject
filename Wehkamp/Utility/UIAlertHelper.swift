//
//  UIAlertHelper.swift
//  Touchwonders
//
//  Created by Garaj on 25/04/2017.
//  Copyright © 2017 garaj. All rights reserved.
//

import UIKit

class UIAlertHelper: NSObject {

    static func showAlertView(title:String?,message:String?,completion: ((Bool) -> Swift.Void)?)
    {
        let controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        controller.addAction(UIAlertAction(title: NSLocalizedString("Done", comment: ""), style: UIAlertActionStyle.cancel, handler: { (action:UIAlertAction) in
            if completion != nil
            {
                completion!(true)
            }
        }))
        
        UIHelper.presentViewController(controller:controller)
    }
    
    static func showAlertView(title:String?,message:String?)
    {
        if message == nil && title == nil
        {
            assert(message == nil && title == nil,"message or title must be exist")
        }
        
        showAlertView(title: title, message: message, completion: nil)
    }        
}
