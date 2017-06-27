//
//  String+Additions.swift
//  Touchwonders
//
//  Created by Garaj on 25/04/2017.
//  Copyright © 2017 garaj. All rights reserved.
//

import Foundation
import UIKit

extension String
{
    func encodeUtf8() -> String
    {
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            else
        {
            return ""
        }
        
        return encodedString
    }
    
    func isNumeric() -> Bool
    {
        let num = Int(self)
        if num != nil {
            return true
        }
        else {
            return false
        }
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined(separator: "")
    }
}

