//
//  NotificationCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    
    
    @IBOutlet weak var notifTitleLabel: UILabel!
    @IBOutlet weak var notifDetailLabel: UILabel!
    @IBOutlet weak var notifImageView: UIImageView!
    @IBOutlet weak var notifContainerView: UIView!
    
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
    
    
    
    var notificationModel:NotificationsModel?{
        didSet{
            guard let noti = notificationModel else { return  }
            notifTitleLabel.text = noti.Header ?? ""
            notifDetailLabel.text = noti.Body ?? ""
            
            notifImageView.image = self.notifImageView.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            self.notifImageView.tintColor = APP_ICON_COLOUR
            notifContainerView.layer.cornerRadius = 10
           // self.titleLabel.textColor = PRIMARY_COLOUR
           // self.descriptionLabel.textColor = UIColor.black
            
        }
        
        
        
        
        
    }
    
}
