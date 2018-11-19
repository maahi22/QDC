//
//  TimeCollectionViewCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var formatLabel:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    static var identifier:String{
        return String(describing: self)
    }
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
}
