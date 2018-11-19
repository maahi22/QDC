//
//  ServiceAreaTableViewCell.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 23/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class ServiceAreaTableViewCell: UITableViewCell {

    // MARK: - Injections
    @IBOutlet weak var serviceLocalityLabel: UILabel!
    @IBOutlet weak var serviceSubLocalityLabel: UILabel!
    
    static var identifier:String{
        return String(describing: self)
    }
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var serviceArea:ServicableAreaModel?{
        didSet{
            guard let serviceArea = serviceArea else { return  }
            serviceLocalityLabel.text = serviceArea.Locality ?? ""
            serviceSubLocalityLabel.text = serviceArea.SubLocality ?? ""
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
    
}
