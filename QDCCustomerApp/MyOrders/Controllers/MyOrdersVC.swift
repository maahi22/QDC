//
//  MyOrdersVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 04/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyOrdersVC: UIViewController {
    
    
    
    @IBOutlet private var myOrderViewModel:MyOrderViewModel!
    
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var pendingOrderLabel:UILabel!
    @IBOutlet weak var inProcessLabel:UILabel!
    @IBOutlet weak var dueLabel:UILabel!
    @IBOutlet weak var readyLabel:UILabel!
    @IBOutlet weak var dueImageView:UIImageView!
    @IBOutlet weak var readyImageView:UIImageView!
    @IBOutlet weak var processImageView:UIImageView!
    
    var orderArray:NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerNib()
        self.setupUI()
        
        myOrderViewModel.getMyOrder { [weak self] (orderSummary, message) in
            guard let strongSelf = self else{return}
            
            if let orderSummary = orderSummary {
                DispatchQueue.main.async {
                    
                    strongSelf.pendingOrderLabel.text = orderSummary.TotalOrder
                    strongSelf.inProcessLabel.text = orderSummary.ProcessCloth
                    strongSelf.dueLabel.text = orderSummary.TotalAmount
                    strongSelf.readyLabel.text = orderSummary.ReadyCloth
                    strongSelf.orderTableView.reloadData()
                    
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
        }
    }
    
    
    
    
    @IBAction func notificationClick(_ sender: Any) {
        
        guard let navViewController = NotificationVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? NotificationVC
            else { return  }
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    
    func registerNib() {
        orderTableView.register(MyOrderCell.nib, forCellReuseIdentifier: MyOrderCell.identifier)
    }
    
    func setupUI() {
        
        self.view.backgroundColor = PRIMARY_COLOUR
        self.orderTableView.backgroundColor =  UIColor.white
        
        self.dueImageView.image = self.dueImageView.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.dueImageView.tintColor = APP_ICON_COLOUR
        self.readyImageView.image = self.readyImageView.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.readyImageView.tintColor = APP_ICON_COLOUR
        self.processImageView.image = self.processImageView.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.processImageView.tintColor = APP_ICON_COLOUR
        
    }
    
    
}

extension MyOrdersVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}


extension MyOrdersVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrderViewModel.numberOfmyOrder()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = orderTableView.dequeueReusableCell(withIdentifier: MyOrderCell.identifier, for: indexPath)  as? MyOrderCell else { return UITableViewCell() }
        
        cell.myOrderModel =  myOrderViewModel.myOrderForIndexPath(indexPath)
        return cell
    }
}

extension MyOrdersVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let orderDetailObj = myOrderViewModel.myOrderForIndexPath(indexPath) {
            guard let navViewController = OrderDetailVC.getStoryboardInstance(),
                let  viewController = navViewController.topViewController as? OrderDetailVC
                else { return  }
            viewController.orderDetailModelObj = orderDetailObj
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
}

