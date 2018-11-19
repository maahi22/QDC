//
//  SignUpChoiceVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 21/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit


class SignUpChoiceVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var mobileButon: UIButton!
    var dict : [String : AnyObject]!
    
    @IBOutlet weak var fbView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cornerRadius = imageView.frame.width/2
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        
        facebookButton.setButtonTheme()
        mobileButon.setButtonTheme()
        // Do any additional setup after loading the view.
        

        
        //if the user is already logged in
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }
        
        
        
    }

    @IBAction func mobileSignUpPressed(_ sender: UIButton) {
        guard let navViewController = SignUpTVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? SignUpTVC
            else { return  }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func fbSignUp(_ sender: Any) {
        let loginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [.publicProfile], viewController : self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in")
                self.getFBUserData()
            }
        }
        
    }
    
   
    
    
    
   
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { [weak self] (connection, user, requestError) -> Void in
                if (requestError == nil){
                    
                    guard let strongSelf = self else{return}
                    
                    strongSelf.dict = user as! [String : AnyObject]
//                    self.dict = result as! [String : AnyObject]
//                    print(result!)
//                    print(self.dict)
                    
                    if requestError != nil {
                        print(requestError)
                        return
                    }
                    
                    
                    
                    var pictureUrl = ""
                    
                    if let picture = strongSelf.dict["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String {
                        pictureUrl = url
                    }
                    
                    var senderDict:[String:String] = Dictionary()
                    
                    if let val = strongSelf.dict["email"] as? String{
                        senderDict["email"] = val
                    }else{
                        senderDict["email"] = ""
                    }
                    if let val = strongSelf.dict["phone"] as? String{
                        senderDict["phone"] = val
                    }else{
                        senderDict["phone"] = ""
                    }
                    
                    if let val = strongSelf.dict["name"] as? String{
                        senderDict["name"] = val
                    }else{
                        senderDict["name"] = ""
                    }
                    if let val = strongSelf.dict["id"] as? String{
                        senderDict["id"] = val
                    }else{
                        senderDict["id"] = ""
                    }
                    senderDict["imageUrl"] = pictureUrl
                    QDCUserDefaults.setUserImgUrl(pictureUrl)
                    
                    
                    
                    guard let navViewController = SignUpTVC.getStoryboardInstance(),
                        let viewController = navViewController.topViewController as? SignUpTVC
                        else { return  }
                    
                    if let name  = senderDict["name"]{
                        viewController.name = name
                    }
                    if let email  = senderDict["email"]{
                        viewController.email = email
                    }
                    if let id  = senderDict["id"]{
                        viewController.fbId = id
                    }
                    if let phone  = senderDict["phone"]{
                        viewController.phoneNumber = phone
                    }
                    if let imageUrl  = senderDict["imageUrl"]{
                        viewController.imgUrl = imageUrl
                    }
                    
                    
                    strongSelf.navigationController?.pushViewController(viewController, animated: true)
                }
            })
        }
    }

    
    

    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpChoiceVC{
    
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController  else { return nil }
        return navViewController
    }
}
