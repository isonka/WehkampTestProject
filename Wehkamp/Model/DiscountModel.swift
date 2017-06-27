//
//  DiscountModel.swift
//  Wehkamp
//
//  Created by Garaj on 20/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import Foundation

struct DiscountModel:Codable {
    var code : String?
    var description : String?
    var amount : Double?
    var vat_amount : Double?    
}
