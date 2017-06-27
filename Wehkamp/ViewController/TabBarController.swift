//
//  TabBarController.swift
//  Wehkamp
//
//  Created by Garaj on 23/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController,UITabBarControllerDelegate {
    
    deinit {
        self.delegate = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        title = "Shop"
        
        changeBasketBadge()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeBasketBadge), name: Constants.basketChangedNotification, object: nil)
    }
    
    @objc func changeBasketBadge()
    {
        guard let numberOfProductsInBasket = SingletonObject.sharedInstance.basketResponse?.basket_items?.count
            else{
                return
        }
        
        let badgeValue = decideBadgeValue(numberOfProducts: numberOfProductsInBasket)
        
        ThreadingHelper.scheduleMain {
            self.tabBar.items?[1].badgeValue = badgeValue
        }        
    }
    
    func decideBadgeValue(numberOfProducts:Int) -> String?
    {
        let badgeValue = NSNumber(integerLiteral: numberOfProducts).stringValue
        if badgeValue == "0"
        {
            return nil
        }
        
        return badgeValue
    }
    
    //MARK: Tabbar Delegate
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController.isKind(of: ProductListViewController.self)
        {
            title = "Shop"
        }
        else if viewController.isKind(of: BasketViewController.self)
        {
            title = "Winkelmand"
        }
        
        return true
    }
}
