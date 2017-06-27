//
//  BasketResponseModel.swift
//  Wehkamp
//
//  Created by Garaj on 20/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

struct BasketResponseModel: Codable {
    var total_discount : Double?
    var total : Double?
    var total_markdown : Double?
    var total_number_of_items : Double?
    var sub_total : Double?
    var shipping_costs : Double?
    var contains_merged_items : Bool?
    var prices_up_to_date : Bool?
    var basket_items : [BasketItemModel]?
}

extension BasketResponseModel
{
    init?(json:[String:Any]) {
        let decoder = JSONDecoder()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            self = try decoder.decode(BasketResponseModel.self, from: jsonData)                        
        }
        catch {
            print(error)
            return
        }
    }
}
