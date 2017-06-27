//
//  ProductListViewController.swift
//  Wehkamp
//
//  Created by Garaj on 21/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//


import UIKit

class ProductListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ProductCellDelegate,ProductViewModelDelegate {
    
    var cellWidth = (ScreenSize.SCREEN_WIDTH - 2) / 2
    var cellHeight = CGFloat(integerLiteral: 200)
    var productViewModel : ProductViewModel?
    {
        didSet {
            productViewModel?.sortProductsForCampaign()
        }
    }
    
    @IBOutlet weak var productCollectionView : UICollectionView!
    
    func decideForCellSize(size:CGSize)
    {
        if DeviceType.IsIpad
        {
            if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight
            {
                self.cellWidth = (size.width - 10) / 6
            }
            else if UIDevice.current.orientation == .portrait
            {
                self.cellWidth = (size.width - 6) / 4
            }
            
            ThreadingHelper.scheduleMain {
                self.productCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decideForCellSize(size: view.frame.size)
        
        productViewModel = ProductViewModel()
        productViewModel?.delegate = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {        
        super.viewWillTransition(to: size, with: coordinator)
        decideForCellSize(size:size)
    }
    
    //MARK: CollectionView Delegate & Data Source
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductReuseIdentifier", for: indexPath) as! ProductCollectionViewCell
        
        productCollectionCell.delegate = self
        productCollectionCell.indexPath = indexPath
        
        let displayItems = productViewModel?.getDisplayedValuesAt(indexPath: indexPath)
        
        productCollectionCell.nameLabel.text = displayItems?.name
        productCollectionCell.priceLabel.text = displayItems?.price
        productCollectionCell.actionLabel.backgroundColor = displayItems?.actionLabelBackgroundColor
        productCollectionCell.actionLabel.text = displayItems?.actionLabel
        productCollectionCell.scratchPriceLabel.attributedText = displayItems?.stracthPrice
        
        return productCollectionCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard  let numberOfItems = productViewModel?.numberOfItems() else
        {
            return 0
        }
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    //MARK: Product Cell Delegate
    
    func addProductToBasket(indexPath: IndexPath, quantity: Int) {
        UIHelper.showLoader()
        
        productViewModel?.addProductToBasket(indexPath: indexPath, quantity: quantity)
    }
    
    //MARK: ViewModel Delegate
    
    func productAddedToBasket() {
        UIHelper.hideLoader()                
    }
    
    func errorOccured(error: String?) {
        UIHelper.hideLoader()
        UIAlertHelper.showAlertView(title: nil, message: error)
    }
}
