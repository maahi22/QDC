//
//  OffersVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class OffersVC: UIViewController {

    
    @IBOutlet var offersViewModel:OffersViewModel!
    @IBOutlet weak var offerTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        offerTableView.register(OfferCell.nib, forCellReuseIdentifier: OfferCell.identifier)
        
        
        
        showLoadingHUD()
        offersViewModel.getOffers {[weak self] (isSuccess, message) in
            guard let strongSelf = self else{return}
            strongSelf.dismissLoadingHUD()
            if isSuccess{
                DispatchQueue.main.async {
                    strongSelf.offerTableView.reloadData()
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OffersVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}



extension OffersVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersViewModel.numberOffers()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OfferCell.identifier, for: indexPath)  as? OfferCell else { return UITableViewCell() }
        cell.Offers = offersViewModel.offersAt(for: indexPath)
        return cell
    }
}

extension OffersVC:UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       /* guard let selectedServiceArea = serviableAreaViewModel.servicableAreaForIndexPath(indexPath) else{
            return
        }
        
        QDCUserDefaults.setBranchId(branchId: selectedServiceArea.BranchID ?? "")
        QDCUserDefaults.setClientID(clientID: selectedServiceArea.ClientID ?? "")
        let serviceArea = try? JSONEncoder().encode(selectedServiceArea)
        
        UserDefaults.standard.set(serviceArea, forKey: "SelectedServiceArea")
        
        navigateToSignUpChoice()*/
        
    }
}




