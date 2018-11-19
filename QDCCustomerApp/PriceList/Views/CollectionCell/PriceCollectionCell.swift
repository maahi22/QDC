//
//  PriceCollectionCell.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PriceCollectionCell: UICollectionViewCell {

    var priceListViewModel:PriceListViewModel!
    
    @IBOutlet weak var priceTableView:UITableView!
    var garmentArray = NSArray()
    var service = ""
    var selectedCat:String?
    
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

    
    func setupUI(garmentArr:NSArray, selectedService:String) {
        
        // self.registerNib()
        //self.garmentArray = garmentArr
        //self.service = selectedService
        //self.priceTableView.reloadData()
    }
    
    func registerCell() {
        priceTableView.register(PriceCell.nib, forCellReuseIdentifier: PriceCell.identifier)
        self.priceTableView.reloadData()
    }
    
}

extension  PriceCollectionCell:UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectedCat = self.selectedCat else {
            return 0
        }
        return priceListViewModel.numberOfPriceList(selectedCat)//self.garmentArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = priceTableView.dequeueReusableCell(withIdentifier: PriceCell.identifier, for: indexPath as IndexPath)  as? PriceCell else { return UITableViewCell() }
        
        
        
        //let garmentDict = self.garmentArray[indexPath.row] as! NSDictionary
        guard let selectedCat = self.selectedCat else {
             return UITableViewCell()
        }
        
        
          let garment = priceListViewModel.priceListForIndexPath(selectedCat, selectedService: service,Index: indexPath as IndexPath) //else {return UITableViewCell()}
        if let text = garment.item{
        cell.titleLabel?.text = text
        }
        if let qty = garment.qty{
            cell.priceLabel?.text = qty
        }
        
//        if let val = garmentDict["Garment"] as? String{
//            let garmentNameCategoryArray = val.components(separatedBy: "-") // Household - Bed Sheet Single
//            cell.textLabel?.text = garmentNameCategoryArray[1]
//        }
        
//        if let val = garmentDict[self.service] as? NSNumber{
//            cell.detailTextLabel?.text = "\(val)"
//        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    
    
}

extension  PriceCollectionCell:UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 51 ;
        
    }
}
