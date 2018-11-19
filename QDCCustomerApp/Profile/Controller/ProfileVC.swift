//
//  ProfileVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet var profileClient:ProfileClient!
    
    
    @IBOutlet weak var userImageView:UIImageView!
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var mobileTextField:UITextField!
    @IBOutlet weak var addressTextField:UITextField!
    @IBOutlet weak var pickupAddressTextField:UITextField!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var ubdateBottomConstraint:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        //self.automaticallyAdjustsScrollViewInsets = false
    }

    func setupUI() {
        
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.height/2
        self.updateButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControl.State.normal)
        self.updateButton.setButtonTheme()
        self.nameTextField.text = QDCUserDefaults.getUserName()
        self.emailTextField.text = QDCUserDefaults.getUserEmail()
        self.mobileTextField.text = QDCUserDefaults.getUserMobile()
        self.addressTextField.text = QDCUserDefaults.getUserAddress()
        
        self.pickupAddressTextField.text = QDCUserDefaults.getUserSubAddress()
        self.updateButton.layer.cornerRadius = 10
        
    }
    
    
    
    @IBAction func UpdateButtonClicks(_ sender: Any) {

        guard
            let name = nameTextField.text, !name.isEmpty,
            let areaLocation = pickupAddressTextField.text, !areaLocation.isEmpty,
            let add = addressTextField.text, !add.isEmpty
            else {
                //doneBarButton.isEnabled = false
                
                showAlertMessage(vc: self, title: .Error, message: "Fill All mandatory fields")
                return
        }
        
        
        self.hitUpdateUserWebService(name, address: add, addressLocation: areaLocation)
    }
    
    
    
    func hitUpdateUserWebService(_ name:String , address:String,addressLocation:String) {
        
        profileClient.updateProfile(areaLocation: address, name: name, address: address) {  [weak self] (status ,customerModel, message)  in
            
            guard let strongSelf = self else{return}
            //  strongSelf.dismissLoadingHUD()
            
            
            if status {
                
                
                QDCUserDefaults.setUserName(userName: name)
                QDCUserDefaults.setUserAddress(adress: address)
                QDCUserDefaults.setUserSubAddress(adress: addressLocation)
                
                showAlertMessage(vc: strongSelf,
                                 title: "Message",
                                 message: message,
                                 actionTitle: "Ok",
                                 handler: { (action) in
                                    strongSelf.sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showHome.rawValue, sender: nil)
                })

            
            
            /*if let cus = customerModel {
            
                
                if let valueString = cus.Name{
                    QDCUserDefaults.setUserName(userName: valueString)
                }
                
                if let valueString = cus.AreaLocation{
                    QDCUserDefaults.setUserAddress(adress: valueString)
                }
                
                
                
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
                }
                */
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
            
        }
    }

}

extension ProfileVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
