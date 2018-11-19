//
//  DashboardVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 26/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {

    @IBOutlet var signUpClient:SignUpClient!
    @IBOutlet var customerSummaryClient:CustomerSummaryClient!
    @IBOutlet var settingsViewModel:SettingsViewModel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var payAmountLabel: UILabel!
    @IBOutlet weak var garmentDueLabel: UILabel!
    @IBOutlet weak var billsImageView: UIImageView!
    @IBOutlet weak var billsLabel: UILabel!
    @IBOutlet weak var garmentImageView: UIImageView!
    @IBOutlet weak var garmentLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var pickUpButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var garmentContainerView: UIView!
    
    var responseObj:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showLoadingHUD()
        customerSummaryClient.getCustomerSummary { [weak self] (customerSummeryModel, message) in
            guard let strongSelf = self else{
                return
            }
            
            if let customerSummeryModel = customerSummeryModel{
                
                DispatchQueue.main.async {
                    
                    strongSelf.garmentDueLabel.text = customerSummeryModel.PendingGarments
                    strongSelf.payAmountLabel.text = customerSummeryModel.PendingAmount
                }
                strongSelf.settingsViewModel.getSettingsinformation(completion: { (isSuccess, message) in
                        strongSelf.dismissLoadingHUD()
                    if !isSuccess{
                           showAlertMessage(vc: strongSelf, title: .Error, message: message)
                    }
                })
                
            }else{
                strongSelf.dismissLoadingHUD()
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
            
            
        }
        
        
        /*if let name = QDCUserDefaults.getUserName(){
            self.userNameLabel.text = name
        }
        
        if let Add = QDCUserDefaults.getUserAddress(){
            self.userAddressLabel.text = Add
        }*/
        
        /*let imgurl = QDCUserDefaults.getUserImgUrl()
        if imgurl != nil || imgurl != ""{
            let img = UIImage(named: "User_Placeholder")
            userImageView.loadImageUsingCacheWithURLString(imgurl, placeHolder: img)
            userImageView.contentMode = .scaleAspectFill
            userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
            userImageView.layer.masksToBounds = true
            
        }
        */
        self.userNameLabel.text = QDCUserDefaults.getUserName()
        self.userAddressLabel.text = QDCUserDefaults.getUserAddress()
        
       // self.garmentLabel.textColor = PRIMARY_COLOUR
        billsLabel.textColor = PRIMARY_COLOUR
        garmentLabel.textColor = PRIMARY_COLOUR
        payAmountLabel.textColor = PRIMARY_COLOUR
        garmentDueLabel.textColor = PRIMARY_COLOUR
        
        billsImageView.image = billsImageView.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        billsImageView.tintColor = PRIMARY_COLOUR
        
        garmentImageView.image = garmentImageView.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        garmentImageView.tintColor = PRIMARY_COLOUR
        
        self.infoView.backgroundColor = PRIMARY_COLOUR
        
       // self.shareButton.tintColor = COLOUR_ON_BUTTON
       // self.shareButton.backgroundColor = GRAY_COLOUR_ON_BUTTON
       // self.pickUpButton.tintColor = COLOUR_ON_BUTTON
        self.pickUpButton.setButtonTheme()
//        self.payButton.tintColor = COLOUR_ON_BUTTON
//        self.payButton.backgroundColor = GRAY_COLOUR_ON_BUTTON
//        self.detailsButton.tintColor = COLOUR_ON_BUTTON
//        self.detailsButton.backgroundColor = GRAY_COLOUR_ON_BUTTON
       
    }
    
    //action
    @IBAction func payButtonClick(sender: AnyObject) {
        
        guard let navViewController = DueAmountVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? DueAmountVC
        else { return  }
        viewController.paymentDone = { [weak self]() in
            guard let strongSelf = self else { return  }
             strongSelf.payAmountLabel.text = "0 INR"
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func detailsButtonClick(sender: AnyObject) {
        guard let navViewController = MyOrdersVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? MyOrdersVC
            else { return  }
        self.navigationController?.pushViewController(viewController, animated: true)
       
    }
    
    @IBAction func pickUpButtonClick(sender: AnyObject) {
        guard let navViewController = PickUpDateVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? PickUpDateVC
            else { return  }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func shareButtonClick(sender: AnyObject) {
        
        let activityViewController = UIActivityViewController(activityItems: [QDCUserDefaults.getAppLink()], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func notificationClick(_ sender: Any) {
        
        guard let navViewController = NotificationVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? NotificationVC
            else { return  }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}


extension DashboardVC{
    
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
    
    func setCustomerToken()  {
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let custCode = QDCUserDefaults.getCustomerId()
        signUpClient.getCustomerToken(clientID, BranchID: branchID, CustomerCode: custCode, completion: { [weak self](isSuccess, message) in
            guard let strongSelf = self else{return}
            if isSuccess{
                QDCUserDefaults.setAccessToken(token: message)
                //// fetch customer summary 
                
                ////
                
            }else{
                strongSelf.dismissLoadingHUD()
                
                showAlertMessage(vc: strongSelf, title: .Message, message: message)
            }
        })
    }
    
    //functions
   /* func setupUI() {
        
        if QDCUserDefaults.getUserImgUrl().characters.count > 0 {
            let downloadURL = NSURL(string: QDCUserDefaults.getUserImgUrl())!
            Alamofire.request(.GET, downloadURL).response { (request, response, data, error) in
                self.userImageView.image = UIImage(data: data!, scale:1)
            }
        }
        
        //self.billsImageView.image = UIImage.init(named: BILLS_IMAGE, inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil)
        //self.garmentImageView.image = UIImage.init(named: GARMENT_IMAGE, inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil)
        //self.view.backgroundColor = UIColor.lightGrayColor()
        //self.separatorView.backgroundColor = UIColor.lightGrayColor()
        self.billsImageView.image = self.billsImageView.image!.imageWithRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.billsImageView.tintColor = APP_ICON_COLOUR
        self.garmentImageView.image = self.garmentImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.garmentImageView.tintColor = APP_ICON_COLOUR
        
        self.userNameLabel.textColor = UIColor.grayColor()
        self.userAddressLabel.textColor = UIColor.redColor()
        self.summaryLabel.textColor = UIColor.whiteColor()
        self.billsLabel.textColor = PRIMARY_COLOUR
        self.payAmountLabel.textColor = UIColor.redColor()
        self.garmentDueLabel.textColor = UIColor.redColor()
        self.garmentLabel.textColor = PRIMARY_COLOUR
        self.infoView.backgroundColor = PRIMARY_COLOUR
        self.shareButton.tintColor = COLOUR_ON_BUTTON
        self.shareButton.backgroundColor = GRAY_COLOUR_ON_BUTTON
        self.pickUpButton.tintColor = COLOUR_ON_BUTTON
        self.pickUpButton.backgroundColor = BUTTON_COLOUR
        self.payButton.tintColor = COLOUR_ON_BUTTON
        self.payButton.backgroundColor = GRAY_COLOUR_ON_BUTTON
        self.detailsButton.tintColor = COLOUR_ON_BUTTON
        self.detailsButton.backgroundColor = GRAY_COLOUR_ON_BUTTON
        
        self.userNameLabel.text = QDCUserDefaults.getUserName()
        self.userAddressLabel.text = QDCUserDefaults.getUserAddress()
        
        self.infoView.layer.cornerRadius = 8
        self.profileView.layer.cornerRadius = 8
        self.pickUpButton.layer.cornerRadius = 8
        self.shareButton.layer.cornerRadius = 8
        self.payButton.layer.cornerRadius = 8
        self.detailsButton.layer.cornerRadius = 8
        
        
        var path = UIBezierPath(roundedRect:self.payAmountLabel.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSizeMake(4, 4))
        var maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.payAmountLabel.layer.mask = maskLayer
        
        path = UIBezierPath(roundedRect:self.garmentDueLabel.bounds, byRoundingCorners:[.TopLeft, .BottomLeft], cornerRadii: CGSizeMake(6, 6))
        maskLayer = CAShapeLayer()
        maskLayer.path = path.CGPath
        self.garmentDueLabel.layer.mask = maskLayer
        
    }*/
    
   /* func refreshUi() {
        
        let str = responseObj?.objectForKey(AMOUNT_DASHBOARD_RESPONSE_KEY) as? String
        self.payAmountLabel.text = str?.stringByReplacingOccurrencesOfString("INR", withString: "")
        self.garmentDueLabel.text = responseObj?.objectForKey(GARMENT_DASHBOARD_RESPONSE_KEY) as? String
    }*/
}
