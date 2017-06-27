//
//  Formatter.swift
//  Wehkamp
//
//  Created by Garaj on 22/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import Foundation

struct Formatter {
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "€"
        formatter.currencyCode = ","
        return formatter
    }()
}
