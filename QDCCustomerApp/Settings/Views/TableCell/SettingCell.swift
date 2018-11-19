//
//  SettingCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 18/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    
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
    
}
