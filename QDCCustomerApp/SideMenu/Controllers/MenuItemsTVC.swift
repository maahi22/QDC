//
//  MenuItemsWithHeaderVC.swift
//  I-Helper
//
//  Created by Kripa Tripathi on 17/11/17.
//  Copyright © 2017 Maxtra Technologies P LTD. All rights reserved.
//

import UIKit


class MenuItemsTVC: UITableViewController {
    
    @IBOutlet weak var menuHeaderView: UIView!
    @IBOutlet weak var menuHeaderImageView: UIImageView!
    
    @IBOutlet weak var menuHeaderTitleLabel: UILabel!
    
    
    var menuItems :[Section] = [Section]()
    let bgLayer = CAShapeLayer()
    
    func setUserProfileImage(_ image:UIImage)  {
        menuHeaderImageView.image = image
        menuHeaderImageView.contentMode = .scaleAspectFill
        menuHeaderImageView.layer.cornerRadius = menuHeaderImageView.frame.size.width / 2
        menuHeaderImageView.layer.masksToBounds = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tableView.rowHeight = 50
        tableView.backgroundColor = mainColor
        
        menuHeaderTitleLabel.text = APP_NAME
        
        //tableView.setTableViewBackgroundGradient(#colorLiteral(red: 0.8705882353, green: 0.8509803922, blue: 0.7882352941, alpha: 1), #colorLiteral(red: 0.09929890186, green: 0.1892752349, blue: 0.70184201, alpha: 1))
        //tableView.separatorStyle = .none
        /*if let userImageData = UserDefaults.standard.data(forKey: "empayUserImageData"), let image = UIImage(data: userImageData) {
            
            setUserProfileImage(image)
        }*/
       /* if let user = getLoggedUser(), let userName = user.Name{
            menuHeaderTitleLabel.text = userName.capitalized
        }*/
        let imgurl = QDCUserDefaults.getUserImgUrl()
        if imgurl != nil || imgurl != ""{
            let img = UIImage(named: "User_Placeholder")
            menuHeaderImageView.loadImageUsingCacheWithURLString(imgurl, placeHolder: img)
            
            menuHeaderImageView.contentMode = .scaleAspectFill
            menuHeaderImageView.layer.cornerRadius = menuHeaderImageView.frame.size.width / 2
            menuHeaderImageView.layer.masksToBounds = true
            
        }
        
        
        tableView.register(MenuItemTableViewCell.nib, forCellReuseIdentifier: MenuItemTableViewCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getMenuItems() { [weak self](menuItems) in
            guard let strongSelf = self else{return}
            strongSelf.menuItems = menuItems
            strongSelf.tableView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setup()
        //configure()
    }
    
}

extension MenuItemsTVC{
    
    
    
    class func getSideMenuImageArray() -> NSArray {
        return ["Side Offer Icons","Side My PickupsIcon","Side Request Pick Up Icon","Side Due Amount Icon","Side My Order Icon","Side Price List Icon",
                //"Offer Icon",
                
                "Side Feedback Icon","Setting.png","Side Request Pick Up Icon"]
    }
    //MARK: - Menu Items Model
    fileprivate func getMenuItems(completion:([Section])->())  {
        let menuItems = [
            Section(name: "DASHBOARD", items: [], image:"Side Offer Icons", selImage: "", expanded: false,itemType:MenuItemType.home),
            Section(name: "REQUEST PICKUP", items: [], image: "Side My PickupsIcon", selImage: "", expanded: false,itemType:MenuItemType.pickUp),
            Section(name: "MY REQUEST", items: [], image: "Side Request Pick Up Icon", selImage: "", expanded: false,itemType:MenuItemType.myRequest),
            // Section(name: "Fee Payment History", items: [], image: "", selImage: "", expanded: false,itemType:MenuItemType.feepaymenthistory),
            
            Section(name: "DUE AMOUNT", items: [], image: "Side Due Amount Icon", selImage: "", expanded: false,itemType:MenuItemType.dueAmount),
            Section(name: "MY ORDERS", items: [], image: "Side My Order Icon", selImage: "", expanded: false,itemType:MenuItemType.myOrder),
            Section(name: "PRICE LIST", items: [], image: "Side Price List Icon", selImage: "", expanded: false,itemType:MenuItemType.priceList),
            //Section(name: "OFFERS", items: [], image: "Offer Icon", selImage: "", expanded: false,itemType:MenuItemType.offers),
            Section(name: "FEEDBACK", items: [], image: "Side Feedback Icon", selImage: "", expanded: true,itemType:MenuItemType.feedback),
            Section(name: "SETTING", items: [], image: "Setting.png", selImage: "", expanded: false,itemType:MenuItemType.settings),
            
            
            Section(name: "ABOUT US", items: [], image: "Side Request Pick Up Icon", selImage: "", expanded: false,itemType:MenuItemType.aboutUs)
        ]
        
        
        
        completion(menuItems)
    }
    
    
    //MARK: - Functions
    
    
    
    
    
    func setCenterView(index:Int)  {
        
        switch menuItems[index].itemType {
        case .home:
            
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showHome.rawValue, sender: nil)
        case .signout:
            userLogout()
        case .pickUp:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showPickUp.rawValue, sender: nil)
        case .myRequest:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showMyRequest.rawValue, sender: nil)
        case .dueAmount:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showDueAmount.rawValue, sender: nil)
        case .feepaymenthistory:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showFeePaymentHistory.rawValue, sender: nil)
        case .myOrder:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showMyOrder.rawValue, sender: nil)
        case .mywallet:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showMyWallet.rawValue, sender: nil)
        case .profile:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showProfile.rawValue, sender: nil)
          
            
        case .priceList:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showPriceList.rawValue, sender: nil)
        case .offers:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showOffer.rawValue, sender: nil)
        case .feedback:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showFeedback.rawValue, sender: nil)
        case .settings:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showSettings.rawValue, sender: nil)
        case .aboutUs:
            sideMenuController?.performSegue(withIdentifier: SideMenuOptions.showAboutUs.rawValue, sender: nil)
            
            //profileOptions()
        case .contact:
            print("Contact")
        case .email:
            print("Email")
        case .none:
            print("none")
        
        }
    }
    
    func userLogout()  {
    }
    
    func profileOptions()  {
        let alertController = UIAlertController.init(title: "User Profile", message: nil, preferredStyle: .actionSheet)
        //Logout Action
        let changePasswordAction = UIAlertAction.init(title: "Change PIN", style: .default){
            [weak self] action in
            guard let strongSelf = self else{return}
           
            
        }
        
        //Logout Action
        let changeSecurityQuesAction = UIAlertAction.init(title: "Change Security Question", style: .default){
            [weak self] action in
            guard let strongSelf = self else{return}
           
        }
        //Cancel Action
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(changePasswordAction)
        
        alertController.addAction(changeSecurityQuesAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}

extension MenuItemsTVC{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.identifier, for: indexPath) as? MenuItemTableViewCell else { return UITableViewCell() }
        cell.menuItem = menuItems[indexPath.row]
        return cell
    }
}

extension MenuItemsTVC{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        setCenterView(index: indexPath.row)
    }
}











