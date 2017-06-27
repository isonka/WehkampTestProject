//
//  BasketViewController.swift
//  Wehkamp
//
//  Created by Garaj on 23/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,BasketViewModelDelegate,HorizontalQuantityViewDelegate {
    
    @IBOutlet weak var basketTableView: UITableView!
    
    var viewModel = BasketViewModel()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        reloadBasket()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        basketTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 0.01))
        basketTableView.backgroundView = emptyBasketView(size: view.frame.size)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadBasket), name: Constants.basketChangedNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: Visuals
    
    func emptyBasketView(size:CGSize)-> UIView?
    {
        if viewModel.numberOfItems() == 0
        {
            let emptyBasketView = UIView(frame: basketTableView.frame)
            emptyBasketView.backgroundColor = UIColor.white
            let emptyBasketLabel = UILabel(frame: CGRect(x: 15, y: (emptyBasketView.frame.size.height - 100) / 2, width: size.width - 30, height: 100))
            emptyBasketLabel.text = "Je winkelmand is leeg"
            emptyBasketLabel.textColor = UIColor.darkGray
            emptyBasketLabel.numberOfLines = 0
            emptyBasketLabel.textAlignment = .center
            emptyBasketView.addSubview(emptyBasketLabel)
            
            let shopNowButton = UIButton(frame: CGRect(x: 15, y: emptyBasketLabel.frame.origin.y + emptyBasketLabel.frame.size.height + 15, width: size.width - 30, height: 40))
            shopNowButton.addTarget(self, action: #selector(shopNowTapped), for: .touchUpInside)
            shopNowButton.setTitle("ga naar de shop", for: .normal)
            shopNowButton.backgroundColor = .red
            shopNowButton.setTitleColor(.white, for: .normal)
            emptyBasketView.addSubview(shopNowButton)
            
            return emptyBasketView
        }
        return nil
    }
    
    //MARK: Actions
    
    @objc func shopNowTapped()
    {
        tabBarController?.selectedIndex = 0
    }
    
    //MARK: Observers
    
    @objc private func reloadBasket()
    {
        UIHelper.hideLoader()
        ThreadingHelper.scheduleMain {
            self.basketTableView.backgroundView = self.emptyBasketView(size:self.view.frame.size)
            self.basketTableView.reloadData()
        }
    }
    
    //MARK: TableView Delegate & Data Source
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Verwijder") { [weak self] (action, indexPath) in
            
            UIHelper.showLoader()
            self?.basketTableView.setEditing(false, animated: true)
            self?.viewModel.deleteItemAt(indexPath: indexPath)
        }
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.numberOfItems() - 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTotalReuseIdentifier", for: indexPath) as! BasketTotalTableViewCell
            
            cell.priceLabel.text = viewModel.basketTotalPrice()
            
            return cell
        }
        else{
            let displayedItem = viewModel.getDisplayedValuesAt(indexPath: indexPath)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCellReuseIdentifier", for: indexPath) as! BasketTableViewCell
            
            cell.quantityView.tag = indexPath.row
            cell.quantityView.delegate = self
            
            cell.quantityView.setQuantity(quantity: displayedItem.quantity)
            cell.nameLabel.text = displayedItem.name
            cell.priceLabel.text = displayedItem.price
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    //MARK: Quantity Delegate
    
    func updateQuantity(quantity: Int, indexPath: IndexPath) {
        viewModel.updateQuantityAt(indexPath: indexPath, quantity: quantity)
    }
    
    //MARK: BasketViewModelDelegate
    
    func errorOccured(message: String?) {
        UIHelper.hideLoader()
        guard let errorMessage = message else
        {
            return
        }
        UIAlertHelper.showAlertView(title: nil, message: errorMessage)        
        reloadBasket()
    }
}
