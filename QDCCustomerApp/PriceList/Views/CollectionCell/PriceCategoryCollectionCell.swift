//
//  PriceCategoryCollectionCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PriceCategoryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel:UILabel!
    @IBOutlet weak var selectedView:UIView!
    
    
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
