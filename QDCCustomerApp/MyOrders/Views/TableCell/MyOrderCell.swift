//
//  MyOrderCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyOrderCell: UITableViewCell {

    
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var clothLabel: UILabel!
    @IBOutlet weak var clothImageView:UIImageView!
    @IBOutlet weak var priceImageView:UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    static var identifier:String{
        return String(describing: self)
    }
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    var myOrderModel:OrderDetailsModel?{
        didSet{
            guard let orderDetailObj = myOrderModel else { return  }
            
            
            self.orderLabel.text = orderDetailObj.OrderNo
            self.dateLabel.text = orderDetailObj.OrderDate
            self.statusLabel.text = orderDetailObj.Status
            self.priceLabel.text = orderDetailObj.TotalAmount
            self.clothLabel.text = orderDetailObj.TotalGarments
            
        }
    }
    
    func setupUI(orderDetailObj:OrderDetailsModel) {
        
        self.clothImageView.image = self.clothImageView.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.clothImageView.tintColor = APP_ICON_COLOUR
        self.priceImageView.image = self.priceImageView.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.priceImageView.tintColor = APP_ICON_COLOUR
        
        self.orderLabel.text = orderDetailObj.OrderNo
        self.dateLabel.text = orderDetailObj.OrderDate
        self.statusLabel.text = orderDetailObj.Status
        self.priceLabel.text = orderDetailObj.TotalAmount
        self.clothLabel.text = orderDetailObj.TotalGarments
        
    }
    
    
    
    
    
}
