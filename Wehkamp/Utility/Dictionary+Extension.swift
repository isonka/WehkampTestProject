//
//  Dictionary+Extension.swift
//  Wehkamp
//
//  Created by Garaj on 20/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

extension NSDictionary
{
    func toData() -> Data
    {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}
