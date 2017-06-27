//
//  UINib+Additions.swift
//  Wehkamp
//
//  Created by Garaj on 22/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import Foundation
import UIKit

fileprivate extension UINib {
    
    static func nib(named nibName: String) -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static func loadSingleView(_ nibName: String, owner: Any?) -> UIView {
        return nib(named: nibName).instantiate(withOwner: owner, options: nil)[0] as! UIView
    }
}

// MARK: App Views

extension UINib {
    class func loadQuantityView(_ owner: AnyObject) -> UIView {
        return loadSingleView("QuantityView", owner: owner)
    }
    
    class func loadHQuantityView(_ owner: AnyObject) -> UIView {
        return loadSingleView("HorizontalQuantityView", owner: owner)
    }
}
