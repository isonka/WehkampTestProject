//
//  BaseNavigationViewController.swift
//  Wehkamp
//
//  Created by Garaj on 20/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.black,NSAttributedStringKey.font.rawValue:UIFont(name: "", size: 16) ?? UIFont.systemFont(ofSize: 16)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
