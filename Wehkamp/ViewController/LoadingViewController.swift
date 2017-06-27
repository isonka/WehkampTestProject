//
//  LoadingViewController.swift
//  Wehkamp
//
//  Created by Garaj on 25/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController
{
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loadingImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingImageView.layer.shadowColor = UIColor.white.cgColor
        loadingImageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        loadingImageView.layer.shadowRadius = 0.3
        loadingImageView.layer.shadowOpacity = 0.5
        
        loadingLabel.layer.shadowColor = UIColor.white.cgColor
        loadingLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        loadingLabel.layer.shadowRadius = 0.3
        loadingLabel.layer.shadowOpacity = 0.5
    }
    
    
}
