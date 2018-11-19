//
//  FeedBackVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class FeedBackVC: UIViewController {

    
    @IBOutlet private var feedbackClient:FeedbackClient!
    
    @IBOutlet weak var feedbackTextView:UITextView!
    @IBOutlet weak var countLabel:UILabel!
    @IBOutlet weak var feedbackLabel:UILabel!
    @IBOutlet weak var sendButton: UIButton!
    var hideMenuOnNav:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    func setupUI() {
        
        self.sendButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControl.State.normal)
        self.sendButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControl.State.selected)
        self.sendButton.setButtonTheme()
        
    }
    
    
    @IBAction func sendButtonClick() {
        
        
        guard let feedback = self.feedbackTextView.text else{return}
        
        feedbackClient.sendFeedBack(messageString: feedback) { [weak self]  (status, message) in
            
            guard let strongSelf = self else{return}
            showAlertMessage(vc: strongSelf,
                             title: "Message",
                             message: message,
                             actionTitle: "Ok",
                             handler: { (action) in
                            strongSelf.sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showHome.rawValue, sender: nil)
            })
            //showAlertMessage(vc: strongSelf, title: .Message, message: message)
            
        }
    }
    
    
    
    
    func hitFeedbackWebService() {
       
        
        /* var tempDict:[String:AnyObject]? = nil
        tempDict = ["CustomerCode":QDCUserDefaults.getCustomerId(), "DatabaseName": QDCUserDefaults.getDataBaseName(),"Message": self.feedbackTextView.text!,"BranchID":QDCUserDefaults.getBranchId()]
        let dict:NSDictionary? = NSDictionary.init(object: tempDict!, forKey: kWebServicePostParamKey)
        QDCFeedbackWebService.hitApi(dict!, responseValue: { (isSuccess, response,header, error) ->
            Void in
            if isSuccess{
                
                self.feedbackTextView.text = ""
                self.feedbackLabel.hidden = false
                
                let alert:UIAlertView = UIAlertView(title:"" , message: "Thank you for your valuable feedback", delegate: self, cancelButtonTitle: "ok")
                alert.show()
                
            }else{
                
            }
        })*/
        
        
    }
    
   /* func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        let controller = UIStoryboard.addDashBoardViewController() as QDCDashboardViewController
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBarHidden = true
        self.revealViewController().pushFrontViewController(navigationController, animated: true)
    }
    
    */
    
}


extension FeedBackVC:UITextViewDelegate{
    
    
    private func textViewDidBeginEditing(textView:UITextView) {   //delegate method
        textView.text = "";
        self.feedbackLabel.isHidden = true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.count >= 1000 {
            return false
        }
        self.countLabel.text = "\(textView.text.count)/1000 Max Characters"
        return true
    }
    
    
}

extension FeedBackVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
