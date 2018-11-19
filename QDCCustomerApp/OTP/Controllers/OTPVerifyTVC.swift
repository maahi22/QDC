//
//  OTPVerifyTVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 25/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class OTPVerifyTVC: UITableViewController {
    @IBOutlet var signUpClient:SignUpClient!
    
    
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var verifyButton: UIButton!
    
    var customerCreationModel:CustomerCreationModel?
    var checkExistingCustomerModel:CheckExistingCustomerModel?
    var isExistingCustomer:Bool = false
    override func viewDidLoad() {

        super.viewDidLoad()
        let cornerRadius = imageView.frame.width/2
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        verifyButton.setButtonTheme()
        otpTextField.addDoneButtonToKeyboard(myAction:#selector(otpTextField.resignFirstResponder))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func resendPressed(_ sender: UIButton) {
        //// Resend OTP
        
        let customerCode = QDCUserDefaults.getCustomerId()
        let accessToken = QDCUserDefaults.getAccessToken()
        var clientId = ""
        var branchId = ""
        
        if isExistingCustomer{
            guard let checkExistingCustomerModel = checkExistingCustomerModel,
                let clientID = checkExistingCustomerModel.ClientID,
                let branchID = checkExistingCustomerModel.BranchID
                else {
                    return
            }
            branchId = branchID
            clientId = clientID
           
        }else{
           
            guard let customerCreationModel = customerCreationModel,
                let clientID = customerCreationModel.ClientID,
                let branchID = customerCreationModel.BranchID
                else {
                    return
            }
            branchId = branchID
            clientId = clientID
        }
        showLoadingHUD()
        signUpClient.reSendOTP(clientId, BranchID: branchId, CustomerCode: customerCode, completion: {[weak self] (isSuccess, message) in
            guard let strongSelf = self else {return}
            strongSelf.dismissLoadingHUD()
            if !isSuccess{
             showAlertMessage(vc: strongSelf, title: .Message, message: message)
            }
        })
        ////
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    @IBAction func verifyPressed(_ sender: UIButton) {
        guard let otp = otpTextField.text, otp.count == 4 else{
            showAlertMessage(vc: self, title: .Message, message: "Enter a valid OTP.")
            return
        }
        let customerCode = QDCUserDefaults.getCustomerId()
        let accessToken = QDCUserDefaults.getAccessToken()
        if isExistingCustomer{
            guard let checkExistingCustomerModel = checkExistingCustomerModel,
                let clientID = checkExistingCustomerModel.ClientID,
                let branchID = checkExistingCustomerModel.BranchID
                else {
                    return
            }
            
              verifyOTP(clientID: clientID, branchID: branchID, customerCode: customerCode, otp: otp, token: accessToken)
        }else{
            guard let customerCreationModel = customerCreationModel,
            let clientID = customerCreationModel.ClientID,
            let branchID = customerCreationModel.BranchID
            else {
                return
            }
            
            verifyOTP(clientID: clientID, branchID: branchID, customerCode: customerCode, otp: otp, token: accessToken)
            
        }
    }
    
    func verifyOTP(clientID:String, branchID:String, customerCode:String, otp:String, token:String)  {
        
        showLoadingHUD()
        signUpClient.OTPCheck(clientID, BranchID: branchID, CustomerCode: customerCode, OTP: otp, token:token) { [weak self](otpCheckModel, message) in
            guard let strongSelf = self else{return}
            strongSelf.dismissLoadingHUD()
            if let otpCheckModel = otpCheckModel, otpCheckModel.OTPMatch.lowercased() == "true"{
                
                UserDefaults.standard.set(true, forKey: USER_DEFAULT_OTP_CORRECT_KEY)
                UserDefaults.standard.synchronize()
                guard let mainView = UIStoryboard(name: Screens.SideMenu.rawValue, bundle: nil).instantiateInitialViewController() as? CustomSideMenuViewController
                    else{
                        return
                }
                
                //guard let navViewController = DashboardVC.getStoryboardInstance() else{return}
                strongSelf.present(mainView, animated: true, completion: nil)
            }else{
                
                showAlertMessage(vc: strongSelf, title: .Message, message: "Incorrect OTP please try again.")
            }
        }
    }
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension OTPVerifyTVC{
    
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}


extension OTPVerifyTVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 4
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

}
