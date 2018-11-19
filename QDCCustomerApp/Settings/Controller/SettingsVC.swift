//
//  SettingsVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet var settingsViewModel:SettingsViewModel!
    @IBOutlet weak var settingTableView: UITableView!
    
    var settingArray = ["Notifications", "My Profile", "Default Payment Method", "Feedback", "Call Us", "Share"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView.register(SettingCell.nib, forCellReuseIdentifier: SettingCell.identifier)

       // self.settingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        settingsViewModel.getSettingsinformation { [weak self] (isSuccess, message) in
            
            guard let strongSelf = self else{return}
            if isSuccess{
                DispatchQueue.main.async {
                    //strongSelf.informationTableView.reloadData()
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
            
        }
    }

    
    
    

}


extension SettingsVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}


extension SettingsVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        guard let settingCell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath)  as? SettingCell else { return UITableViewCell() }
        
        
        if indexPath.row == 2 {
            settingCell.selectionStyle = UITableViewCell.SelectionStyle.none
            settingCell.contentView.backgroundColor = UIColor.lightGray
            settingCell.contentView.alpha = 0.5
        }else{
            settingCell.selectionStyle = UITableViewCell.SelectionStyle.none
            settingCell.contentView.backgroundColor = UIColor.clear
        }
        
    
        settingCell.textLabel?.backgroundColor = .clear
        settingCell.textLabel?.text = settingArray[indexPath.row]
        return settingCell
    }
    
    private func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.1))
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    
}

extension SettingsVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
        
    }
    
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            
            
            guard let navViewController = NotificationVC.getStoryboardInstance(),
                let viewController = navViewController.topViewController as? NotificationVC
                else { return  }
            viewController.hideMenuOnNav = true
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
//            let controller = UIStoryboard.addNotificationViewController() as QDCNotificationViewController
//            controller.hideMenuOnNav = true
//            self.navigationController?.pushViewController(controller, animated: true)
            //self.performSegueWithIdentifier(SEGUE_NOTIFICATION_IDENTIFIER, sender: self)
            
        case 1:
            
            guard let navViewController = ProfileVC.getStoryboardInstance(),
                let viewController = navViewController.topViewController as? ProfileVC
                else { return  }
            self.navigationController?.pushViewController(viewController, animated: true)
            //self.performSegueWithIdentifier(SEGUE_PROFILE_IDENTIFIER, sender: self)
            
        case 3:
            guard let navViewController = FeedBackVC.getStoryboardInstance(),
                let viewController = navViewController.topViewController as? FeedBackVC
                else { return  }
            self.navigationController?.pushViewController(viewController, animated: true)
            /*let controller = UIStoryboard.addFeedbackViewController() as QDCFeedBackViewController
            controller.hideMenuOnNav = true
            self.navigationController?.pushViewController(controller, animated: true)*/
            
        case 4:
            
            let num:String = QDCUserDefaults.getClientPhoneNumber()
            if let url = NSURL(string: "tel://\(num)"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.openURL(url as URL)
            }
            
        case 5:
            
            /*guard let navViewController = FeedBackVC.getStoryboardInstance(),
                let viewController = navViewController.topViewController as? FeedBackVC
                else { return  }
            
            self.present(navViewController, animated: true, completion: {})*/
            
            let activityViewController = UIActivityViewController(activityItems: [QDCUserDefaults.getAppLink()], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: {})
            
        default: break
            
        }
        
    }
}
