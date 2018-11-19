//
//  PickUpVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 06/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PickUpDateVC: UIViewController {

    @IBOutlet private var pickUpDateViewModel:PickUpDateViewModel!
    @IBOutlet private var schedulePickUpDateClient:SchedulePickUpDateClient!
    
    @IBOutlet weak var timeSelectionCollectionView:UICollectionView!
    @IBOutlet weak var dateSelectionCollectionView:UICollectionView!
    @IBOutlet weak var specialInstructionTextView:UITextField!
    @IBOutlet weak var firstButton:UIButton!
    @IBOutlet weak var secondButton:UIButton!
    @IBOutlet weak var firstButtonRadioImage:UIImageView!
    @IBOutlet weak var secondButtonRadioImage:UIImageView!
    @IBOutlet weak var schedulePickupButton:UIButton!
    @IBOutlet weak var containerScrollView:UIScrollView!
    @IBOutlet weak var timeCollectionBottomConstraint:NSLayoutConstraint!
    
    var pickupNumber:String = ""
    var showDropOff:Bool = false
    var requireDropOff:Bool = false
    var selectedDate:String = ""
    var selectedTime:String = ""
    var pickUpScheduleArray:NSMutableArray = NSMutableArray()
    var selectedDateIndex : Int = 2
    var selectedExpressDeliveryButton : Int = 0  //0 means none of them is selected 1 means first is selected 2 means second is selected
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateSelectionCollectionView.register(DateCollectionViewCell.nib, forCellWithReuseIdentifier: DateCollectionViewCell.identifier)
        
        timeSelectionCollectionView.register(TimeCollectionViewCell.nib, forCellWithReuseIdentifier: TimeCollectionViewCell.identifier)

        self.setupUI()
        
        
        
        
        schedulePickUpDateClient.getScheduleDetails { [weak self](scheduleDetailModel, message) in
            guard let strongSelf = self else{return}
            if let scheduleDetailModel = scheduleDetailModel {
                
                if scheduleDetailModel.ShowDropOff == "True" {
                    strongSelf.showDropOff = true
                    
                    //strongSelf.timeCollectionBottomConstraint.constant = 120
                    
                    
                    if let arr = scheduleDetailModel.ExpressDelivery1 as? NSArray {
                        if arr.count > 0 {
                            
                            let dic = arr[0] as! ExpressDelivery
                            
                            if let val = dic.Value as? String {
                                strongSelf.firstButton.setTitle(val, for: UIControl.State.normal)
                                strongSelf.firstButton.tag = Int((dic.Key as? String)!)! //tag will be used as key
                                
                            }
                        }
                    }
                    if let arr = scheduleDetailModel.ExpressDelivery2 as? NSArray {
                        if arr.count > 0 {
                            let dic = arr[0] as! ExpressDelivery
                            
                            if let val = dic.Value as? String {
                                strongSelf.secondButton.setTitle(val, for: UIControl.State.normal)
                                strongSelf.secondButton.tag = Int((dic.Key as? String)!)! //tag will be used as key
                            }
                        }
                    }
                    
                    
                    
                }else{
                    strongSelf.showDropOff = false
                   // strongSelf.timeCollectionBottomConstraint.constant = 80
                }
            
            
                if scheduleDetailModel.DropOffRequired == "False" {
                    strongSelf.requireDropOff = true
                }
            
               // strongSelf.view.layoutIfNeeded()
            }else{
               // showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
        }
        
        
        
        pickUpDateViewModel.getPickUpDate { [weak self] (isSuccess, message) in
            guard let strongSelf = self else{return}
            
            if isSuccess {
                DispatchQueue.main.async {
                    
                    strongSelf.dateSelectionCollectionView.reloadData()
                    guard let dateStr =  strongSelf.pickUpDateViewModel.pickUpFirstDate() else {return }
                    strongSelf.selectedDate = dateStr
                    guard let time =  strongSelf.pickUpDateViewModel.pickUpFirstTime() else {return }
                    strongSelf.selectedTime = time
                    strongSelf.timeSelectionCollectionView.reloadData()
                    
                    
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
        }
    }

    
    
    
    
    @IBAction func notificationClick(_ sender: Any) {
        
        guard let navViewController = NotificationVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? NotificationVC
            else { return  }
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    
    func setupUI() {
        self.specialInstructionTextView.textColor = TEXT_FIELD_COLOUR
        
        self.firstButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.firstButton.backgroundColor = UIColor.white
        
        self.secondButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.secondButton.backgroundColor = UIColor.white
        
        self.schedulePickupButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControl.State.normal)
        self.schedulePickupButton.setButtonTheme()
    }
    
    @IBAction func schedulePickupButtonClick(sender: AnyObject) {
        
        if self.selectedExpressDeliveryButton == 0 && self.showDropOff == true {
            //none of them is selected and user can select drop then send to drop off controller
            
            
            guard let navViewController = DropOffVC.getStoryboardInstance(),
                let viewController = navViewController.topViewController as? DropOffVC
                else { return  }
            
            var instruction = ""
            if self.specialInstructionTextView.text != "Special Instruction"{
                instruction = self.specialInstructionTextView.text!
            }
            viewController.requireDropOff = self.requireDropOff
            viewController.pickupNumber = self.pickupNumber
            viewController.selectedPickupDate = self.selectedDate
            viewController.selectedPickupTime = self.selectedTime
            viewController.pickUpInstruction = instruction
            viewController.isComingFromPickUp = true
            
            
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
        }else {
            //user has selected fast delivery or he can not choose drop off
            if self.pickupNumber.isEmpty {
                //Fresh Pick Up hence flag = 1
                self.hitRequestPickupWebService(flag: 1)
            }else{
                //Reschedule hence flag = 2
                self.hitRequestPickupWebService(flag: 2)
            }
        }
        
    }

    
    func hitRequestPickupWebService(flag:Int) {
        //flag 1 for request new pick up and 2 for reschedule
        var expressId:String
        
        switch self.selectedExpressDeliveryButton {
        case 0:
            expressId = ""
        case 1:
            expressId = "\(self.firstButton.tag)"
        case 2:
            expressId = "\(self.secondButton.tag)"
        default:
            expressId = ""
        }
        
        var instruction = ""
        
        
        
        if self.specialInstructionTextView.text == "Special Instruction"{
            instruction = ""
        }else if let inst = self.specialInstructionTextView.text{
            instruction = inst
        }
        
        showLoadingHUD()
        
        var dropOffD = ""
        var dropOffT = ""
        if let expId = Int (expressId){
            if expId > 0 {
                
                dropOffD =   CommonUtilities.getDateFromStringAddedDay(dateString: self.selectedDate, day: expId)
                dropOffT = self.selectedTime
            }
        }
        
        
        schedulePickUpDateClient.getSchedulePickup(pickupDate: self.selectedDate, pickupTime: self.selectedTime, flag: flag, pickupNumber: self.pickupNumber, expressDeliveryID: expressId, specialInstruction: instruction, dropOffDate: dropOffD, dropOffTime: dropOffT, cancelReason: nil) { [weak self](schedulePickUpModel, message) in
            
            guard let strongSelf = self else{return}
            
            strongSelf.dismissLoadingHUD()
            if let schedulePickUpModel = schedulePickUpModel {
               
                if schedulePickUpModel.Status == "False" {
                    
                    showAlertMessage(vc: strongSelf, title: .Error, message: schedulePickUpModel.Reason)
                    
                }
                else{
                
                
                strongSelf.pickupNumber = schedulePickUpModel.Status
                
                    
                    
                    if strongSelf.selectedExpressDeliveryButton != 0 {
                        //this means either of the express delivery is selected send to congratulation screen with pick up and drop off message
                        //self.performSegueWithIdentifier(SEGUE_CONGRATULATIONS_SCHEDULE_IDENTIFIER, sender: self)
                        
                       /* guard let navViewController = DropOffVC.getStoryboardInstance(),
                            let viewController = navViewController.topViewController as? DropOffVC
                            else { return  }
                        
                        var instruction = ""
                        if strongSelf.specialInstructionTextView.text != "Special Instruction"{
                            instruction = strongSelf.specialInstructionTextView.text!
                        }
                        viewController.requireDropOff = strongSelf.requireDropOff
                        viewController.pickupNumber = strongSelf.pickupNumber
                        viewController.selectedPickupDate = strongSelf.selectedDate
                        viewController.selectedPickupTime = strongSelf.selectedTime
                        viewController.pickUpInstruction = instruction
                        viewController.isComingFromPickUp = true
                         strongSelf.navigationController?.pushViewController(viewController, animated: true)
                        */
                        
                        
                        guard let navViewController = SuccessfullPickUpVC.getStoryboardInstance(),
                            let viewController = navViewController.topViewController as? SuccessfullPickUpVC
                            else { return  }
                        viewController.message = "Your Pickup has been scheduled for \n \(strongSelf.selectedDate), \(strongSelf.selectedTime) \n\nand Dropoff has been scheduled for \n \(schedulePickUpModel.DropOffDateAndTimeSlot)"
                        viewController.pickUpOrderId = strongSelf.pickupNumber
                        viewController.selectedPickupDate = strongSelf.selectedDate
                        viewController.selectedPickupTime = strongSelf.selectedTime
                        strongSelf.navigationController?.pushViewController(viewController, animated: true)
                        
                    } else {
                        //send to congratulations screen with pick up only message
                        //self.performSegueWithIdentifier(SEGUE_CONGRATULATIONS_SCHEDULE_IDENTIFIER, sender: self)
                        
                        guard let navViewController = SuccessfullPickUpVC.getStoryboardInstance(),
                            let viewController = navViewController.topViewController as? SuccessfullPickUpVC
                            else { return  }
                        viewController.message = "Your Pickup has been scheduled for \n \(strongSelf.selectedDate), \(strongSelf.selectedTime) \n\nand Dropoff has been scheduled for \n \(schedulePickUpModel.DropOffDateAndTimeSlot)"
                        viewController.pickUpOrderId = strongSelf.pickupNumber
                        viewController.selectedPickupDate = strongSelf.selectedDate
                        viewController.selectedPickupTime = strongSelf.selectedTime
                        strongSelf.navigationController?.pushViewController(viewController, animated: true)
                    }
                    
//                    guard let navViewController = SuccessfullPickUpVC.getStoryboardInstance(),
//                        let viewController = navViewController.topViewController as? SuccessfullPickUpVC
//                        else { return  }
//                    viewController.message = "Your Pickup has been scheduled for \n \(strongSelf.selectedDate), \(strongSelf.selectedTime)"
//                    viewController.pickUpOrderId = strongSelf.pickupNumber
//                    viewController.selectedPickupDate = strongSelf.selectedDate
//                    viewController.selectedPickupTime = strongSelf.selectedTime
//                    strongSelf.navigationController?.pushViewController(viewController, animated: true)
                    
                }
            
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
        }
        
    }
    
    
    
    @IBAction func firstButtonClick(sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        self.secondButton.isSelected = false
        
        if sender.isSelected {
            self.firstButtonRadioImage.isHighlighted = true
        }else{
            self.firstButtonRadioImage.isHighlighted = false
        }
        
        self.secondButtonRadioImage.isHighlighted = false
        
        if sender.isSelected {
            selectedExpressDeliveryButton = 1
        }else{
            selectedExpressDeliveryButton = 0
        }
    }
    
    @IBAction func secondButtonClick(sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        self.firstButton.isSelected = false
        
        if sender.isSelected {
            self.secondButtonRadioImage.isHighlighted = true
        }else{
            self.secondButtonRadioImage.isHighlighted = false
        }
        
        self.firstButtonRadioImage.isHighlighted = false
        
        if sender.isSelected {
            selectedExpressDeliveryButton = 2
        }else{
            selectedExpressDeliveryButton = 0
        }
        
    }
    
    
    
    
    
    
    
}



extension PickUpDateVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}




extension PickUpDateVC:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            
            if indexPath.row == 0 || indexPath.row == 1 {
                return // previos dates
            }
            
            // let scheduleModel = self.pickUpScheduleArray.objectAtIndex(indexPath.item) as? QDCScheduleModel
            guard let selDate = pickUpDateViewModel.pickUpDate(for: indexPath) else{ return }
            
             self.selectedDate = selDate
             //self.selectedTime = (scheduleModel?.timeArray.objectAtIndex(0))! as! String
             self.selectedDateIndex = indexPath.item
             self.dateSelectionCollectionView.reloadData()
             self.timeSelectionCollectionView.reloadData()
 
        }else{
            
             //let scheduleModel = self.pickUpScheduleArray.objectAtIndex(selectedDateIndex) as? QDCScheduleModel
            guard let timeStr = pickUpDateViewModel.pickUpTime(for: indexPath, pickUpDate: self.selectedDate) else{return}
             self.selectedTime = timeStr //(scheduleModel?.timeArray.objectAtIndex(indexPath.item))! as! String
             self.timeSelectionCollectionView.reloadData()
        }
    }
    
    
}

extension PickUpDateVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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

extension PickUpDateVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return pickUpDateViewModel.numberOfPickUpDate()
        }else{
        
            return pickUpDateViewModel.numberOfPickUpTime(pickUpDate:selectedDate)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView.tag == 1 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as? DateCollectionViewCell else { return UICollectionViewCell() }
            //cell.dateLabel.text = pickUpDateViewModel.pickUpDate(for: indexPath)
        guard let dateStr =  pickUpDateViewModel.pickUpDate(for: indexPath) else {return UICollectionViewCell()  }
        if indexPath.row == 0 || indexPath.row == 1 {
            cell.contentView.backgroundColor = .lightGray
            cell.dayLabel.textColor = .gray
            cell.dateLabel.textColor = .gray
            cell.monthLabel.textColor = .gray
        }else{
            //let scheduleModel = self.pickUpScheduleArray.objectAtIndex(indexPath.item) as? QDCScheduleModel
            //dateString = (scheduleModel?.date)!
            cell.contentView.backgroundColor = UIColor.white
            cell.dateLabel.textColor = BUTTON_COLOUR
            cell.dayLabel.textColor = UIColor.darkGray
            cell.monthLabel.textColor = UIColor.darkGray
        }
        
        let tempArr = dateStr.components(separatedBy: " ")
        cell.dayLabel.text = CommonUtilities.getWeekDayFromString(dateString: dateStr)
        cell.dateLabel.text = tempArr[0]
        cell.monthLabel.text = tempArr[1] 
        
        if dateStr == self.selectedDate {
            cell.arrowImageView.isHidden = false
        }else{
            cell.arrowImageView.isHidden = true
        }
            return cell
        }else{

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as? TimeCollectionViewCell else { return UICollectionViewCell() }

            
            guard let timeString = pickUpDateViewModel.pickUpTime(for: indexPath, pickUpDate: selectedDate) else{return UICollectionViewCell()}
            
            if timeString.contains("AM") {
                cell.timeLabel.text = timeString.replacingOccurrences(of: "AM", with: "")
                cell.formatLabel.text = "AM"
            }else{
                cell.timeLabel.text = timeString.replacingOccurrences(of: "PM", with: "")
                cell.formatLabel.text = "PM"
            }

            if timeString == self.selectedTime {
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


extension PickUpDateVC:UITextViewDelegate{

    func textViewDidBeginEditing(_ textView: UITextView) {
        print("print1")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("print2")
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        return true
    }
}

