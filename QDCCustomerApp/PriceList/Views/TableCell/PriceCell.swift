//
//  PriceCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PriceCell: UITableViewCell {

    
    @IBOutlet weak var priceContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
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
    
    
    func setupUI() {
        
//        var rct = self.priceContainerView.bounds
//        rct.size.width = SCREEN_SIZE.width-20
//        priceContainerView.layer.shadowColor = UIColor.black.cgColor
//        priceContainerView.layer.shadowOpacity = 0.5
//        priceContainerView.layer.shadowOffset = CGSize.zero
//        priceContainerView.layer.shadowRadius = 3
//        priceContainerView.layer.shadowPath = UIBezierPath(rect: rct).cgPath
//        priceContainerView.layer.shouldRasterize = true
        
    }
}
