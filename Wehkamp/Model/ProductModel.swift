//
//  ProductModel.swift
//  Wehkamp
//
//  Created by Garaj on 20/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

struct ProductModel : Codable {
    var Number : String?
    var Name : String?
    var ActionLabelBackgroundColor : String?
    var ActionLabel : String?
    var ModelVideo : String?
    var Video : String?
    var Price : Double?
    var ScratchPrice : Double?
    var Rating : Double?
    var ListPriceLabel : Bool?
    var IsInCampaign : Bool?
    var cellHeight : CGFloat?
}
