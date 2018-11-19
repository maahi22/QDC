//
//  MyRequestsVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyRequestsVC: UIViewController{
    
    @IBOutlet var myRequestViewModel:MyRequestViewModel!
    
    
    @IBOutlet  var schedulePickUpDateClient:SchedulePickUpDateClient!
    @IBOutlet  var ScheduleDropOffClient:ScheduleDropOffClient!
    
   
    

    @IBOutlet weak var tableContainerView:UIView!
   // @IBOutlet weak var mainScrollView:UIScrollView!
    @IBOutlet weak var myPickUpsTableView:UITableView!
    @IBOutlet weak var myDropOffsTableView:UITableView!
    @IBOutlet weak var myPickUpsButton:UIButton!
    @IBOutlet weak var myDropOffsButton:UIButton!
    @IBOutlet weak var viewUnderPickup:UIView!
    @IBOutlet weak var viewUnderDropoff:UIView!
    
    
    
    var isPickUpSelected:Bool = true
    //var dropOffModelArr:NSArray = NSArray()
    var selectedMyRequestModel:MyRequestModel?
    var selectedMyRequestDropOffModel:MyRequestDropOffModel?
    var cancelIndexPath:IndexPath?
    var clickedRow:Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        myPickUpsTableView.register(MyRequestCell.nib, forCellReuseIdentifier: MyRequestCell.identifier)
        myDropOffsTableView.register(MyRequestCell.nib, forCellReuseIdentifier: MyRequestCell.identifier)
    
        myPickUpsTableView.tag = 1;
        myDropOffsTableView.tag = 2;
        
        self.myPickUpsButton.isSelected = true
        self.myDropOffsButton.isSelected = false
        
        myPickUpsTableView.isHidden = false
        myDropOffsTableView.isHidden = true
        
        self.viewUnderPickup.backgroundColor = PRIMARY_COLOUR
        self.viewUnderDropoff.backgroundColor = UIColor.white
        
        
        

        self.hitMyRequestWebService()
    }

    
    
   
    @IBAction func notificationClick(_ sender: Any) {
    
        guard let navViewController = NotificationVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? NotificationVC
            else { return  }
        self.navigationController?.pushViewController(viewController, animated: true)
    
    }
    
    
    
    
    @IBAction func myPickUpsButtonClick(_ sender: Any) {
        
        self.isPickUpSelected = true
        self.myPickUpsButton.isSelected = true
        self.myDropOffsButton.isSelected = false
        //self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.viewUnderPickup.backgroundColor = PRIMARY_COLOUR
        self.viewUnderDropoff.backgroundColor = UIColor.white
        
        
        myPickUpsTableView.isHidden = false
        myDropOffsTableView.isHidden = true
        
        self.hitMyRequestWebService()
    }
    
    
    @IBAction func myDropOffsButtonClick(_ sender: Any) {
        
        
        
        self.isPickUpSelected = false
        self.myPickUpsButton.isSelected = false
        self.myDropOffsButton.isSelected = true
       // self.mainScrollView.contentOffset = CGPoint(x:SCREEN_SIZE.width,y:0)
        self.viewUnderDropoff.backgroundColor = PRIMARY_COLOUR
        self.viewUnderPickup.backgroundColor = UIColor.white
        
        myPickUpsTableView.isHidden = true
        myDropOffsTableView.isHidden = false
        
        self.hitMyDropOffRequestWebService()
        
        
    }
    
    
    
    func hitMyRequestWebService(){
        showLoadingHUD()
        myRequestViewModel.getMyRequest { [weak self] (isSuccess, message)  in
            
            guard let strongSelf = self else{return}
            strongSelf.dismissLoadingHUD()
            if isSuccess {
                DispatchQueue.main.async {
                    strongSelf.myPickUpsTableView.reloadData()
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
            
        }
    }
    
    func hitMyDropOffRequestWebService(){
        //Load data
        showLoadingHUD()
        myRequestViewModel.getDropOff { [weak self] (isSuccess, message)  in
            guard let strongSelf = self else{return}
            strongSelf.dismissLoadingHUD()
            if isSuccess {
                DispatchQueue.main.async {
                    strongSelf.myPickUpsTableView.isHidden = true
                    strongSelf.myDropOffsTableView.isHidden = false
                    strongSelf.myDropOffsTableView.reloadData()
                }
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
        }
    }
}

extension MyRequestsVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}

extension MyRequestsVC:MyRequestCellDelegate{
    /*func didSelectCancelButton(_ myRequestModel: MyRequestModel?) {
        if self.isPickUpSelected  {
            selectedMyRequestModel = myRequestModel
            //Add cancel view
            guard let navViewController = CancelReasonVC.getStoryboardInstance(),
                let viewController = navViewController.topViewController as? CancelReasonVC
                else { return  }
            viewController.cancelOrderdelegate = self
            viewController.modalPresentationStyle = .overCurrentContext
            navViewController.modalPresentationStyle = .overCurrentContext
            self.present(navViewController, animated: true, completion: {})
        }
    }*/
    
    
    func didSelectRescheduleButton(_ Index: IndexPath) {
        if self.isPickUpSelected  {
            
            guard  let pickUpObj = myRequestViewModel.myRequestAt(for: Index) else{
                return
            }
            
            
            guard let navViewController = PickUpDateVC.getStoryboardInstance(),
                let viewController = navViewController.topViewController as? PickUpDateVC
                else { return  }
            if let picNo = pickUpObj.PickUpNumber{
                viewController.pickupNumber = picNo
            }
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
        }else{
            
            
            guard  let dropOffObj = myRequestViewModel.myRequestDropOffAt(for: Index) else{
                return
            }
            
            guard let navViewController = DropOffVC.getStoryboardInstance(),
                let viewController = navViewController.topViewController as? DropOffVC
                else { return  }
            if let picNo = dropOffObj.PickUpNumber{
                viewController.pickupNumber = picNo
            }
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
        }
    }
    
    
    func didSelectCancelButton(_ index: IndexPath) {
        
        cancelIndexPath = index
        if self.isPickUpSelected  {
            
            guard  let pickUpObj = myRequestViewModel.myRequestAt(for: index) else{
                return
            }
            selectedMyRequestModel = pickUpObj
            
        }else{
            guard  let dropOffObj = myRequestViewModel.myRequestDropOffAt(for: index) else{
                return
            }
         selectedMyRequestDropOffModel = dropOffObj
          
        }
        
        
        //Add cancel view
        guard let navViewController = CancelReasonVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? CancelReasonVC
            else { return  }
        viewController.cancelOrderdelegate = self
        viewController.indexP = index
        viewController.modalPresentationStyle = .overCurrentContext
        navViewController.modalPresentationStyle = .overCurrentContext
        self.present(navViewController, animated: true, completion: {})
        
    }
    
    
}

extension MyRequestsVC:CancelReasonDelegate{
  
    
    func didSelectCancelReason(_ cancelReason: String, indexPath: IndexPath?) {
        if self.isPickUpSelected {
            
            if let indexPath = indexPath{
                showLoadingHUD()
                myRequestViewModel.cancelPickUpRequest(cancelReason, index: indexPath) {  [weak self] (isSuccess, message) in
                    
                    guard let strongSelf = self else{return}
                    strongSelf.dismissLoadingHUD()
                    if isSuccess {
                        //remove Cell code
                        DispatchQueue.main.async {
                            strongSelf.myPickUpsTableView.beginUpdates()
                            strongSelf.myPickUpsTableView.deleteRows(at: [indexPath], with: .automatic)
                            strongSelf.myPickUpsTableView.endUpdates()
                        }
                    }
                    else{
                        
                        showAlertMessage(vc: strongSelf, title: .Message, message: message)
                    }
                }
            }
            
        }else{
            
            if let indexPath = indexPath{
                showLoadingHUD()
                myRequestViewModel.cancelDropOffRequest(cancelReason, index: indexPath) {  [weak self] (isSuccess, message) in
                    
                    guard let strongSelf = self else{return}
                    strongSelf.dismissLoadingHUD()
                    if isSuccess {
                        //remove Cell code
                        DispatchQueue.main.async {
                            strongSelf.myDropOffsTableView.beginUpdates()
                            strongSelf.myDropOffsTableView.deleteRows(at: [indexPath], with: .automatic)
                            strongSelf.myDropOffsTableView.endUpdates()
                        }
                    }else{
                        
                        showAlertMessage(vc: strongSelf, title: .Message, message: message)
                    }
                }
            }
            
        }
    }
    
   
    
   }


extension MyRequestsVC:UITableViewDataSource{
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.1))
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return myRequestViewModel.numberMyRequest()
        }else{
            return myRequestViewModel.numberMyRequestDropOff()
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView.tag == 1 {
            
             guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRequestCell.identifier, for: indexPath)  as? MyRequestCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.requestCelldelegate = self
            cell.setupUI()
            cell.indexPath = indexPath
            cell.tblView = self.myPickUpsTableView
            cell.myRequestModel = myRequestViewModel.myRequestAt(for: indexPath)
            cell.arrowLabel.isHidden = true
            cell.historyTableView.isHidden = true
            
            
            return cell
            
        }else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRequestCell.identifier, for: indexPath)  as? MyRequestCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.requestCelldelegate = self
            cell.setupUI()
            cell.indexPath = indexPath
            cell.tblView = self.myDropOffsTableView
            cell.serveMyDropoff = myRequestViewModel.myRequestDropOffAt(for: indexPath)
            cell.arrowLabel.isHidden = true
            
            if let list = cell.dropOffModel?.History {
                
                if list.count > 0 {
                    
                    if list.count > 1 {
                        cell.arrowLabel.isHidden = false
                        cell.historyTableView.isHidden = true
                    }else{
                        cell.arrowLabel.isHidden = true
                        cell.historyTableView.isHidden = true
                    }
                    
                    if ((clickedRow != nil) && (clickedRow == indexPath.row)) {
                        cell.arrowLabel.isHidden = true
                        cell.historyTableView.isHidden = false
                        cell.showRescheduleDetail(dropOffObj: cell.dropOffModel!)
                    }
                }
            }
            
            
            return cell
            
        }
        
   
    }
}

extension MyRequestsVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if tableView.tag == 1 { //pickup table
            return 85
        }
        
        
        if let listitem = myRequestViewModel.dropOffModel {
        
        if listitem.count  > indexPath.row {
            
            let dropOffModel = myRequestViewModel.myRequestDropOffAt(for: indexPath)
            
            if ((clickedRow != nil) && (clickedRow == indexPath.row)){
               
                if let list = dropOffModel?.History {
                  return CGFloat(80 + (list.count - 1) * 63 + 22)
                }else{
                   return 80
                }
                
                
            } else {
                return 80
            }

            //return 80
        }else{
            return 80
        }
        }else{
            return 80
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.tag == 2 {
            if ((clickedRow != nil) && (clickedRow == indexPath.row)){
                clickedRow = nil
            }else {
                clickedRow = indexPath.row
            }
            self.myDropOffsTableView.reloadData()
        }
        
    }
}


