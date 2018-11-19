//
//  CancelReasonVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

protocol CancelReasonDelegate:class {
    
    func didSelectCancelReason(_ cancelReason:String,indexPath:IndexPath?) ;
    
}

class CancelReasonVC: UIViewController {

    
    
    
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerVeiwBottomConstraint: NSLayoutConstraint!
    var selectedButton : UIButton!
    weak var cancelOrderdelegate:CancelReasonDelegate?
    var indexP:IndexPath?
    let reasonArray:NSArray = ["I changed my mind","Pickup date already passed","I was just checking it","Will do it later"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.isOpaque = false
        view.backgroundColor = .clear
        
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.setupUI()
    }

    func setupUI() {
        
        self.reasonTextView.delegate = self
        self.reasonTextView.textColor = TEXT_FIELD_COLOUR
        self.submitButton.backgroundColor = BUTTON_COLOUR
        self.submitButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControl.State.normal)
        
        containerVeiwBottomConstraint.constant = (SCREEN_SIZE.height - self.containerView.frame.size.height)/2
    }
    
    
    
    
    
    @IBAction func radioButtonClick(_ sender: UIButton) {
    
    
        if self.selectedButton != nil {
            self.selectedButton.isSelected = false
        }
        
        sender.isSelected = true
        selectedButton = sender
        
        
    }
    
   
    
    @IBAction func dismissButtonClick(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func submitButtonClick(_ sender: Any) {
    
    var reason = ""
        if self.reasonTextView.text == " reason" {
            reason = ""
        }else{
            reason = self.reasonTextView.text
        }
        
        if self.selectedButton != nil {
            
            if self.selectedButton.tag == 5 {
                
                if reason.isEmpty {
                    
                    showAlertMessage(vc: self, title: .Message, message: "Please provide the reason")
                    
                    
                    return
                }
            }else{
                let indx = self.selectedButton.tag-1
                reason = self.reasonArray[indx] as! String
            }
        }else {
            
             showAlertMessage(vc: self, title: .Message, message: "Please select some reason")
            
            return
        }
        
        
        self.navigationController?.dismiss(animated: true, completion: nil)
        self.cancelOrderdelegate?.didSelectCancelReason(reason, indexPath: self.indexP)
    }
    
    
    

}

extension CancelReasonVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}

extension CancelReasonVC:UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView:UITextView) {   //delegate method
        
        textView.text = "";
        containerVeiwBottomConstraint.constant = 250
        
    }
    
    func textViewDidEndEditing(_ textView:UITextView) {
        
        containerVeiwBottomConstraint.constant = (SCREEN_SIZE.height - self.containerView.frame.size.height)/2
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}
