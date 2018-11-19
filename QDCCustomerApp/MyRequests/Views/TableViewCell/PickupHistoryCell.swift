//
//  PickupHistoryCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PickupHistoryCell: UITableViewCell {

    
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var fromTimeLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var toTimeLabel: UILabel!
    
    
    
    static var identifier:String{
        return String(describing: self)
    }
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    func setupUI(dropOffHistory:HistoryModel) {
        
        self.eventTypeLabel.text = dropOffHistory.EventType
        self.eventDateLabel.text = dropOffHistory.EventDate
        self.eventTimeLabel.text = dropOffHistory.EventTime
        self.fromDateLabel.text = dropOffHistory.FromDate
        self.fromTimeLabel.text = dropOffHistory.FromTime
        self.toDateLabel.text = dropOffHistory.ToDate
        self.toTimeLabel.text = dropOffHistory.ToTime
        
    }
    
    
    
    
}
