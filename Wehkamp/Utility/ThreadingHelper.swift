//
//  ThreadingHelper.swift
//  Touchwonders
//
//  Created by Garaj on 25/04/2017.
//  Copyright © 2017 garaj. All rights reserved.
//

import UIKit

struct ThreadingHelper {
    
    static func scheduleMain(block: @escaping ()->Void)
    {
        DispatchQueue.main.async {
            block()
        }
    }
    
    static func scheduleBackground(block: @escaping ()->Void)
    {
        DispatchQueue.global(qos: .background).async {
            block()
        }
    }
}

