//
//  DateCollectionViewCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dayLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var monthLabel:UILabel!
    @IBOutlet weak var arrowImageView:UIView!
    
    
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
