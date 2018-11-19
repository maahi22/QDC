//
//  SelectLocalityVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 21/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class SelectLocalityVC: UIViewController {

    @IBOutlet var serviableAreaViewModel:ServiableAreaViewModel!
   @IBOutlet weak var backButon: UIButton!
    @IBOutlet weak var  tableView:UITableView!
    
    var isBackButtonHidden = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tableView.register(ServiceAreaTableViewCell.nib, forCellReuseIdentifier: ServiceAreaTableViewCell.identifier)
        tableView.rowHeight = 80
        //skipButon.setButtonTheme()
        backButon.isHidden = isBackButtonHidden
        showLoadingHUD()
        serviableAreaViewModel.getServicableArea {[weak self] (isSuccess, message) in
            guard let strongSelf = self else{return}
            strongSelf.dismissLoadingHUD()
            if isSuccess{
                DispatchQueue.main.async {
                        strongSelf.tableView.reloadData()
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
        }
    }

//    @IBAction func skipPressed(_ sender: UIBarButtonItem) {
//        navigateToSignUpChoice()
//    }
   
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigateToSignUpChoice()  {
        guard let navViewController = SignUpChoiceVC.getStoryboardInstance(),
       let  viewController = navViewController.topViewController as? SignUpChoiceVC
            else { return  }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SelectLocalityVC{
    
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController() as? UINavigationController else { return nil }
        return navViewController
    }
}
extension SelectLocalityVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviableAreaViewModel.numberOfServicableAreas()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceAreaTableViewCell.identifier, for: indexPath)  as? ServiceAreaTableViewCell else { return UITableViewCell() }
        cell.serviceArea = serviableAreaViewModel.servicableAreaForIndexPath(indexPath)
        return cell
    }
    
}

extension SelectLocalityVC:UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedServiceArea = serviableAreaViewModel.servicableAreaForIndexPath(indexPath) else{
            return
        }
        
        QDCUserDefaults.setBranchId(branchId: selectedServiceArea.BranchID ?? "")
        QDCUserDefaults.setClientID(clientID: selectedServiceArea.ClientID ?? "")
        QDCUserDefaults.setDataBaseName(dbName: selectedServiceArea.DatabaseName ?? "")
    
        QDCUserDefaults.setLocality(locality: selectedServiceArea.Locality ?? "")
        QDCUserDefaults.setSubLocality(locality: selectedServiceArea.SubLocality ?? "" )
      
        
        
        let serviceArea = try? JSONEncoder().encode(selectedServiceArea)
        
        UserDefaults.standard.set(serviceArea, forKey: "SelectedServiceArea")
        navigateToSignUpChoice()
        
    }
    
}
