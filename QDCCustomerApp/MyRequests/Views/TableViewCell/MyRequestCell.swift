//
//  MyRequestCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

protocol MyRequestCellDelegate:class {
    
    func didSelectRescheduleButton(_ Index:IndexPath )
    //func didSelectCancelButton(_ myRequestModel:MyRequestModel? )
    func didSelectCancelButton(_ Index:IndexPath )
    
}

class MyRequestCell: UITableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var rescheduleButton:UIButton!
    @IBOutlet weak var cancelButton:UIButton!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    
    var Obj: AnyObject!
    var dropOffModel: MyRequestDropOffModel?
    var indexPath :IndexPath?
    var tblView :UITableView?
    weak var requestCelldelegate:MyRequestCellDelegate?
    
    
    
    
    static var identifier:String{
        return String(describing: self)
    }
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    
    var myRequestModel:MyRequestModel?{
        didSet{
            guard let serviceArea = myRequestModel else { return  }
            dateLabel.text = serviceArea.PickUpDate ?? ""
            timeLabel.text = serviceArea.PickUpTime ?? ""
            
            Obj = serviceArea as AnyObject
        }
    }
    
    var serveMyDropoff:MyRequestDropOffModel?{
        didSet{
            guard let serviceArea = serveMyDropoff else { return  }
            dateLabel.text = serviceArea.PickUpDate ?? ""
            timeLabel.text = serviceArea.DropOffTime ?? ""
            Obj = serveMyDropoff as AnyObject
            dropOffModel = serveMyDropoff
            
            
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
    func setupUI() {
        
        self.dateLabel.textColor = TEXT_FIELD_COLOUR
        self.timeLabel.textColor = TEXT_FIELD_COLOUR
        
        self.rescheduleButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControl.State.normal)
        self.rescheduleButton.backgroundColor = BUTTON_COLOUR
        
        self.cancelButton.setTitleColor(COLOUR_ON_BUTTON, for: UIControl.State.normal)
        self.cancelButton.backgroundColor = BUTTON_COLOUR
    }
    
    
    
    @IBAction func rescheduleButtonClick(_ sender: UIButton) {
        
    //    guard let index = indexPath else{ return }
        var superview = sender.superview
        while let view = superview, !(view is MyRequestCell) {
            superview = view.superview
        }
        guard let cell = superview as? MyRequestCell else {
            print("button is not contained in a table view cell")
            return
        }
        guard let tbl = tblView else{ return }
        guard let indexPath = tbl.indexPath(for: cell) else {
            print("failed to get index path for cell containing button")
            return
        }
        
        
        requestCelldelegate?.didSelectRescheduleButton( indexPath )
        
    }
    
    
    
    @IBAction func cancelButtonClick(_ sender: UIButton) {
       // guard let index = indexPath else{ return }
        
      //  guard let tbl = tblView else{ return }
      //  let buttonPosition = sender.convert(.zero, to: tbl)//convertPoint(CGPointZero, to: tbl)
      //  guard let  indexPath = tbl.indexPathForRow(atPoint: buttonPosition)else{ return }
//        print("cancel   \(indexPath)")
        
        var superview = sender.superview
        while let view = superview, !(view is MyRequestCell) {
            superview = view.superview
        }
        guard let cell = superview as? MyRequestCell else {
            print("button is not contained in a table view cell")
            return
        }
        guard let tbl = tblView else{ return }
        guard let indexPath = tbl.indexPath(for: cell) else {
            print("failed to get index path for cell containing button")
            return
        }
        
        requestCelldelegate?.didSelectCancelButton(indexPath)
        
    }
    
    
    
    
    
    
    //History cell
    
    func showRescheduleDetail(dropOffObj : MyRequestDropOffModel) {
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
            self.registerCell()
            self.historyTableView.reloadData()
    
    }
    
   
    
    
    
    
    
    func registerCell() {
        historyTableView.register(PickupHistoryCell.nib, forCellReuseIdentifier: PickupHistoryCell.identifier)
    }
    
    
    
    
    
    
}


extension MyRequestCell: UITableViewDelegate,UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        guard let offerCell = historyTableView.dequeueReusableCell(withIdentifier: PickupHistoryCell.identifier, for: indexPath as IndexPath)  as? PickupHistoryCell else { return UITableViewCell() }
        
        
        
        if (dropOffModel?.History?.count)! > 0 {
            
            if let list =  dropOffModel?.History{
                
                let dropOffHistory = list[indexPath.row]
                offerCell.setupUI(dropOffHistory: dropOffHistory)
                self.separatorView.isHidden = true
                
            }else{
                self.separatorView.isHidden = false
            }
            
            
            
            
        }else{
            self.separatorView.isHidden = false
        }
        return offerCell
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if let list =  dropOffModel?.History{
            return list.count
        }else{
            return 0
        }
     }
    

    
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 22
        }
        return 63
        
    }
    
    
    
    
    
    
}
