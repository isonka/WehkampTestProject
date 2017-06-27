//
//  BasketItemModel.swift
//  Wehkamp
//
//  Created by Garaj on 20/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import Foundation

struct BasketItemModel:Codable {
    var availability_text : String?
    var brand : String?
    var color : String?
    var deliverable : Bool?
    var id : String?
    var ean : String?
    var max_items_in_basket : Int?
    var merged : Bool?
    var normalized_name : String?
    var product_type : String?
    var title : String?
    var vat_code : String?
    var scratch_price_to_display : Double?
    var product_number : String?
    var uri_key : String?
    var scratch_price : Double?
    var total_price : Double?
    var original_price : Double?
    var total_scratch_price : Double?
    var price : Double?
    var number_of_products : Double?    
    var size : SizeModel?
    var discounts : [DiscountModel]?
}
