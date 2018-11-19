//
//  NotificationVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    
    @IBOutlet var notificationViewModel:NotificationViewModel!
    
    
    @IBOutlet weak var notificationTableView: UITableView!
    var hideMenuOnNav:Bool = false
    var notificationArr:NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notificationTableView.register(NotificationCell.nib, forCellReuseIdentifier: NotificationCell.identifier)
        showLoadingHUD()
        notificationViewModel.getNotifications { [weak self] (isSuccess, message) in
            
            
            guard let strongSelf = self else{return}
              strongSelf.dismissLoadingHUD()
            if isSuccess{
                DispatchQueue.main.async {
                    strongSelf.notificationTableView.reloadData()
                }
                
            }else{
                //showAlertMessage(vc: strongSelf, title: .Message, message: message)
            }
        }
    }

    

}
extension NotificationVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}


extension NotificationVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationViewModel.numberOffers()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.identifier, for: indexPath)  as? NotificationCell else { return UITableViewCell() }
        cell.notificationModel = notificationViewModel.offersAt(for: indexPath)
        return cell
    }
}

extension NotificationVC:UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}



