//
//  DropOffVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class DropOffVC: UIViewController {

    @IBOutlet private var dropOffViewModel:DropOffViewModel!
    @IBOutlet private var ScheduleDropOffClient:ScheduleDropOffClient!
    @IBOutlet private var schedulePickUpDateClient:SchedulePickUpDateClient!
    
    
    
    @IBOutlet weak var timeSelectionCollectionView:UICollectionView!
    @IBOutlet weak var dateSelectionCollectionView:UICollectionView!
    @IBOutlet weak var scheduleDropOffButton:UIButton!
    @IBOutlet weak var skipDropOffButton:UIButton!
    @IBOutlet weak var scheduleButtonWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var skipButtonWidthConstraint:NSLayoutConstraint!
    
    var pickupNumber:String = ""
    var dropoffNumber:String = ""
    var bookingId:String = ""
    var requireDropOff:Bool = true
    var selectedPickupDate:String = ""
    var selectedPickupTime:String = ""
    var selectedDropOffDate:String = ""
    var selectedDropOffTime:String = ""
    var pickUpInstruction:String = ""
    var isComingFromPickUp = false // this means hit schedule pick up api and not drop off api
    var dropOffUpScheduleArray:NSMutableArray = NSMutableArray()
    var selectedDateIndex : Int = 2
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateSelectionCollectionView.register(DateCollectionViewCell.nib, forCellWithReuseIdentifier: DateCollectionViewCell.identifier)
        
        timeSelectionCollectionView.register(TimeCollectionViewCell.nib, forCellWithReuseIdentifier: TimeCollectionViewCell.identifier)
        self.setupUI()
        
        
        dropOffViewModel.getDropOff(pickupDateKey: self.selectedPickupDate, pickupTimeKey: self.selectedPickupTime) { [weak self] (isSuccess, message) in
            
            guard let strongSelf = self else{return}
            
            if isSuccess {
                DispatchQueue.main.async {
                    
                    strongSelf.dateSelectionCollectionView.reloadData()
                    
                    guard let dateStr =  strongSelf.dropOffViewModel.dropOffFirstDate() else {return }
                    strongSelf.selectedDropOffDate = dateStr
                
                    guard let time =  strongSelf.dropOffViewModel.dropOffFirstTime() else {return }
                    strongSelf.selectedDropOffTime = time
                    
                    
                    strongSelf.timeSelectionCollectionView.reloadData()
                    
                    
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
        }
        
        
        
    }

    func setupUI() {
//        self.specialInstructionTextView.textColor = TEXT_FIELD_COLOUR
//
//        self.firstButton.setTitleColor(UIColor.black, for: UIControlState.normal)
//        self.firstButton.backgroundColor = UIColor.white
//
//        self.secondButton.setTitleColor(UIColor.black, for: UIControlState.normal)
//        self.secondButton.backgroundColor = UIColor.white
//
//        self.schedulePickupButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControlState.normal)
//        self.schedulePickupButton.backgroundColor = BUTTON_COLOUR
    }
    
    
    
    @IBAction func scheduleDropOffButtonClick(_ sender: Any) {
        if isComingFromPickUp {
            //hit request pick up api
            if self.pickupNumber.isEmpty {
                //Fresh Pick Up hence flag = 1
                self.hitRequestPickupWebService(1)
            }else{
                //Reschedule hence flag = 2
                self.hitRequestPickupWebService(2)
            }
            
        }else{
            //hit request drop off api
            if self.dropoffNumber.isEmpty {
                //Fresh drop off hence flag = 1
                self.hitRequesDropOffWebService(1)
            }else{
                //Reschedule hence flag = 2
                self.hitRequesDropOffWebService(2)
            }
        }
    }
    
    @IBAction func skipDropOffButtonClick(_ sender: Any) {
        
        self.selectedDropOffDate = ""
        self.selectedDropOffTime = ""
        
        if self.pickupNumber.isEmpty {
            //Fresh Pick Up hence flag = 1
            self.hitRequestPickupWebService(1)
        }else{
            //Reschedule hence flag = 2
            self.hitRequestPickupWebService(2)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    func hitRequestPickupWebService(_ flag:Int) {
        //flag 1 for request new pick up and 2 for reschedule
        
        showLoadingHUD()
        schedulePickUpDateClient.getSchedulePickup(pickupDate: self.selectedPickupDate, pickupTime: self.selectedPickupTime, flag: flag, pickupNumber: self.pickupNumber, expressDeliveryID: "", specialInstruction: self.pickUpInstruction, dropOffDate: self.selectedDropOffDate, dropOffTime: self.selectedDropOffTime, cancelReason: nil) { [weak self](schedulePickUpModel, message) in
            guard let strongSelf = self else{return}
            strongSelf.dismissLoadingHUD()
            if let schedulePickUpModel = schedulePickUpModel {
                
                if schedulePickUpModel.Status == "False" {
                    
                    showAlertMessage(vc: strongSelf, title: .Error, message: schedulePickUpModel.Reason)
                    
                }else{
                    
                    
                    strongSelf.pickupNumber = schedulePickUpModel.Status
                    guard let navViewController = SuccessfullPickUpVC.getStoryboardInstance(),
                        let viewController = navViewController.topViewController as? SuccessfullPickUpVC
                        else { return  }
                    
                    
                    viewController.message = "Your DropOff has been scheduled for \n \(strongSelf.selectedDropOffDate), \(strongSelf.selectedDropOffTime)"
                    viewController.pickUpOrderId = strongSelf.pickupNumber
                    viewController.selectedPickupDate = strongSelf.selectedDropOffDate
                    viewController.selectedPickupTime = strongSelf.selectedDropOffTime
                    
                    strongSelf.navigationController?.pushViewController(viewController, animated: true)
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
        }
        
        
    }
    
    
    
    
    func hitRequesDropOffWebService(_ flag:Int) {
        
        
        
        showLoadingHUD()
        ScheduleDropOffClient.getScheduleDropOff(dropOffDate: self.selectedDropOffDate, dropOffTime: self.selectedDropOffTime, flag: flag, pickupNumber: self.pickupNumber, bookingNo: self.bookingId, dropOffNumber: self.dropoffNumber, cancelReason: nil) { [weak self](scheduleDropOffModel, message) in
            
            
            guard let strongSelf = self else{return}
            strongSelf.dismissLoadingHUD()
            if let schedulePickUpModel = scheduleDropOffModel {
                
                if schedulePickUpModel.Status == "False" {
                    
                    showAlertMessage(vc: strongSelf, title: .Error, message: schedulePickUpModel.Reason)
                    
                }else{
                    
                    
                    strongSelf.pickupNumber = schedulePickUpModel.Status
                    guard let navViewController = SuccessfullPickUpVC.getStoryboardInstance(),
                        let viewController = navViewController.topViewController as? SuccessfullPickUpVC
                        else { return  }
                    
                    
                    viewController.message = "Your DropOff has been scheduled for \n \(strongSelf.selectedDropOffDate), \(strongSelf.selectedDropOffTime)"
                    viewController.pickUpOrderId = strongSelf.pickupNumber
                    viewController.selectedPickupDate = strongSelf.selectedDropOffDate
                    viewController.selectedPickupTime = strongSelf.selectedDropOffTime
                    
                    strongSelf.navigationController?.pushViewController(viewController, animated: true)
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
        }
    }
    
    
}

extension DropOffVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}




extension DropOffVC:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            
            if indexPath.row == 0 || indexPath.row == 1 {
                return // previos dates
            }
            
            guard let selDate = dropOffViewModel.dropOffDate(for: indexPath) else{ return }
            
            self.selectedDropOffDate = selDate
            
            self.selectedDateIndex = indexPath.item
            self.dateSelectionCollectionView.reloadData()
            self.timeSelectionCollectionView.reloadData()
            
        }else{
            
            
            guard let timeStr = dropOffViewModel.dropOffTime(for: indexPath, dropOffDate: self.selectedDropOffDate) else{return}
            self.selectedDropOffTime = timeStr
            self.timeSelectionCollectionView.reloadData()
        }
    }
    
    
}

extension DropOffVC:UICollectionViewDelegateFlowLayout{
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize:CGSize!
        
        if collectionView.tag == 1 {
            let width = (SCREEN_SIZE.width/5)
            cellSize = CGSize(width: width, height: 85)
        }else{
            let width = (SCREEN_SIZE.width/3)
            cellSize = CGSize(width: width, height: width/2)
            
        }
        
        return cellSize
    }
    
}

extension DropOffVC:UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return dropOffViewModel.numberOfDropOffDate()
        }else{
            
            return dropOffViewModel.numberOfDropOffTime(dropOffDate: selectedDropOffDate)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView.tag == 1 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as? DateCollectionViewCell else { return UICollectionViewCell() }
            
            guard let dateStr =  dropOffViewModel.dropOffDate(for: indexPath) else {return UICollectionViewCell()  }
            if indexPath.row == 0 || indexPath.row == 1 {
                cell.contentView.backgroundColor = .lightGray
                cell.dayLabel.textColor = .gray
                cell.dateLabel.textColor = .gray
                cell.monthLabel.textColor = .gray
            }else{
                
                cell.contentView.backgroundColor = UIColor.white
                cell.dateLabel.textColor = BUTTON_COLOUR
                cell.dayLabel.textColor = UIColor.darkGray
                cell.monthLabel.textColor = UIColor.darkGray
            }
            
            let tempArr = dateStr.components(separatedBy: " ")
            cell.dayLabel.text = CommonUtilities.getWeekDayFromString(dateString: dateStr)
            cell.dateLabel.text = tempArr[0]
            cell.monthLabel.text = tempArr[1]
            
            if dateStr == self.selectedDropOffDate {
                cell.arrowImageView.isHidden = false
            }else{
                cell.arrowImageView.isHidden = true
            }
            return cell
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as? TimeCollectionViewCell else { return UICollectionViewCell() }
            
            
            guard let timeString = dropOffViewModel.dropOffTime(for: indexPath, dropOffDate: selectedDropOffDate) else{return UICollectionViewCell()}
            
            if timeString.contains("AM") {
                cell.timeLabel.text = timeString.replacingOccurrences(of: "AM", with: "")
                cell.formatLabel.text = "AM"
            }else{
                cell.timeLabel.text = timeString.replacingOccurrences(of: "PM", with: "")
                cell.formatLabel.text = "PM"
            }
            
            if timeString == self.selectedDropOffTime {
                cell.contentView.backgroundColor = BUTTON_COLOUR
                cell.timeLabel.textColor = UIColor.white
            }else{
                cell.contentView.backgroundColor = UIColor.white
                cell.timeLabel.textColor = BUTTON_COLOUR
            }
            return cell
        }
    }
    
    
}
