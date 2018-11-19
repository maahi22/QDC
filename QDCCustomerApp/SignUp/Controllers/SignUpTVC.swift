//
//  SignUpTVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 21/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class SignUpTVC: UITableViewController {

    @IBOutlet var signUpClient:SignUpClient!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var signUpButon: UIButton!
   
    var email:String = ""
    var name:String = ""
    var fbId:String = ""
    var phoneNumber : String = ""
    var imgUrl:String = ""
    var isCustExisting = false //if customer is new hit otp otherwise dont.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButon.setButtonTheme()
        let cornerRadius = imageView.frame.width/2
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        nameTextField.addDoneButtonToKeyboard(myAction:#selector(nameTextField.resignFirstResponder))
        mobileTextField.addDoneButtonToKeyboard(myAction:#selector(mobileTextField.resignFirstResponder))
        addressTextField.addDoneButtonToKeyboard(myAction:#selector(addressTextField.resignFirstResponder))
        emailIdTextField.addDoneButtonToKeyboard(myAction:#selector(emailIdTextField.resignFirstResponder))
        
        
        self.nameTextField.text = self.name
        self.emailIdTextField.text = self.email
        self.mobileTextField.text = self.phoneNumber
       
    }

    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signUpPressed(_ sender: UIButton) {
        view.endEditing(true)
        guard let name = nameTextField.text, name.count  > 0 else{
            showAlertMessage(vc: self, title: .Message, message: "Enter a valid name.")
            return
        }
        guard let mobile = mobileTextField.text, mobile.count  == 10 else{
            showAlertMessage(vc: self, title: .Message, message: "Enter a valid mobile number.")
            return
        }
        
        var email = ""
        if let emailId = emailIdTextField.text, emailId.count  > 0{
            if emailId.isValidEmail()
            {
                email = emailId
            }
            else{
                showAlertMessage(vc: self, title: .Message, message: "Enter a valid email id.")
            }
        }
        guard let address = addressTextField.text, address.count  > 0 else{
            showAlertMessage(vc: self, title: .Message, message: "Enter a valid address.")
            return
        }
        //
        
        
            
            guard let data = UserDefaults.standard.data(forKey: "SelectedServiceArea")
                else{
                    return
            }
            let selectedService = try? JSONDecoder().decode(ServicableAreaModel.self, from: data)
        
        guard let selectedServiceArea = selectedService,
        let clientID = selectedServiceArea.ClientID,
        let branchID = selectedServiceArea.BranchID
        else {
            showAlertMessage(vc: self, title: .Message, message: "Service area not found.")
            return  }
        
        
        showLoadingHUD()
        signUpClient.checkExistingCustomer(clientID, branchid: branchID, FaceBookID: fbId, EmailID: email, MobileNo: mobile) { [weak self](response, message) in
            guard let strongSelf = self else{return}
           
            if let response = response{
                if  let isCustExist = response.IsCustExist, isCustExist.lowercased() == "true",
                    let clientID = response.ClientID,
                        let branchID = response.BranchID,
                        let custCode = response.CustCode
                {
                    QDCUserDefaults.setCustomerId(customerId: custCode)
                    
                    if let name = response.CustomerName {
                        QDCUserDefaults.setUserName(userName: name)
                    }
                    
                    if let add = response.CustomerAddress {
                        QDCUserDefaults.setUserAddress(adress: add)
                    }
                    if let email = response.CustomerEmailId {
                        QDCUserDefaults.setUserEmail(email: email)
                    }
                    if let mobNo = response.CustomerMobile {
                        QDCUserDefaults.setUserMobile(mobile: mobNo)
                    }
                    
                    
                    
                    QDCUserDefaults.setClientID(clientID: clientID)
                    guard let viewController = CustomMessageVC.getStoryboardInstance() as? CustomMessageVC
                        else { return  }
                    strongSelf.present(viewController, animated: true, completion: nil)
                    strongSelf.signUpClient.getCustomerToken(clientID, BranchID: branchID, CustomerCode: custCode, completion: { (isSuccess, message) in
                        if isSuccess{
                             QDCUserDefaults.setAccessToken(token: message)
                            //// Resend OTP
                            strongSelf.signUpClient.reSendOTP(clientID, BranchID: branchID, CustomerCode: custCode, completion: { (isSuccess, message) in
                                strongSelf.dismissLoadingHUD()
                                strongSelf.dismiss(animated: true, completion: nil)
                                if isSuccess{
                                    
                                    guard let navViewController = OTPVerifyTVC.getStoryboardInstance(),
                                        let viewController = navViewController.topViewController as? OTPVerifyTVC
                                        else { return  }
                                    viewController.checkExistingCustomerModel = response
                                    
                                   viewController.isExistingCustomer = true
                                    strongSelf.navigationController?.pushViewController(viewController, animated: true)
                                }else{
                                    
                                    
                                    showAlertMessage(vc: strongSelf, title: .Message, message: message)
                                }
                            })
                            ////
                            
                        }else{
                            strongSelf.dismissLoadingHUD()
                            
                             showAlertMessage(vc: strongSelf, title: .Message, message: message)
                        }
                    })
                }
                else if let isCustExist = response.IsCustExist, isCustExist.lowercased() == "false"{
                    strongSelf.signUpClient.customerCreation(name,
                                                             Address: address,
                                                             ClientID: clientID,
                                                             BranchID: branchID,
                                                             FaceBookID: strongSelf.fbId,
                                                             EmailId: email,
                                                             Mobile: mobile,
                                                             DeviceToken: "",
                                                             completion: { (customerCreationModel, message) in
                                                                
                                                                if let customerCreationModel = customerCreationModel,
                                                                    let clientID = customerCreationModel.ClientID,
                                                                    let branchID = customerCreationModel.BranchID
                                                                    
                                                                     {
                                                                        let custCode = message
                                                                        
                                                                        QDCUserDefaults.setCustomerId(customerId: custCode)
                                                                        
                                                                        if let name = customerCreationModel.Name {
                                                                            QDCUserDefaults.setUserName(userName: name)
                                                                        }
                                                                        
                                                                        if let add = customerCreationModel.Address {
                                                                            QDCUserDefaults.setUserAddress(adress: add)
                                                                        }
                                                                        if let email = customerCreationModel.EmailId {
                                                                            QDCUserDefaults.setUserEmail(email: email)
                                                                        }
                                                                        if let pin = customerCreationModel.Pincode {
                                                                            QDCUserDefaults.setPinCode(pin: pin)
                                                                        }
                                                                        if let dbName = customerCreationModel.DataBaseName {
                                                                            QDCUserDefaults.setDataBaseName(dbName: dbName)
                                                                        }
                                                                        if let mobNo = customerCreationModel.Mobile {
                                                                            QDCUserDefaults.setUserMobile(mobile: mobNo)
                                                                        }
                                                                        if let mobNo = customerCreationModel.Mobile {
                                                                            QDCUserDefaults.setUserMobile(mobile: mobNo)
                                                                        }
                                                                        
                                                                        strongSelf.signUpClient.getCustomerToken(clientID, BranchID: branchID, CustomerCode: custCode, completion: { (isSuccess, message) in
                                                  strongSelf.dismissLoadingHUD()
                                                                            if isSuccess{
                                                                            //strongSelf.navigateToOTP()
                                                                            
                                                                            QDCUserDefaults.setAccessToken(token: message)
                                                                            guard let navViewController = OTPVerifyTVC.getStoryboardInstance(),
                                                                                let viewController = navViewController.topViewController as? OTPVerifyTVC
                                                                                else { return  }
                                                                            
                                                                            viewController.customerCreationModel = customerCreationModel
                                                                            strongSelf.navigationController?.pushViewController(viewController, animated: true)
                                                                        }else{
                                                     
                                                                            
                                              
                                                                            showAlertMessage(vc: strongSelf, title: .Message, message: message)
                                                                        }
                                                                    })
                                                                        
                                                                        
                                                                }else{
                                                         
                                              strongSelf.dismissLoadingHUD()
                                                                    showAlertMessage(vc: strongSelf, title: .Message, message: message)
                                                                }
                                                                
                    })
                    
                }
            }else{
                strongSelf.dismissLoadingHUD()
                    showAlertMessage(vc: strongSelf, title: .Message, message: message)
            }
        }
    }
    
    func navigateToOTP()  {
        guard let navViewController = OTPVerifyTVC.getStoryboardInstance(),
        let viewController = navViewController.topViewController as? OTPVerifyTVC
        else { return  }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SignUpTVC{
    
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}

extension SignUpTVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 2 {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else{
            return true
        }
        
    }
    
}
