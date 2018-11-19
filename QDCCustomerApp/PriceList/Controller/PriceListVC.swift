//
//  PriceListVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PriceListVC: UIViewController {

    @IBOutlet var priceListViewModel:PriceListViewModel!
    
    @IBOutlet weak var categorySelectionCollectionView:UICollectionView!
    @IBOutlet weak var priceCollectionView:UICollectionView!
    @IBOutlet weak var showCategoryButton:UIButton!
    
  //  var garmentServicesArray = [];
    var selectedService:String = "Dry Cleaning"
    var selectedCategory:String = ""
    var responseGarmentDict:NSDictionary = [String:[NSDictionary]]() as NSDictionary
    var categoryArr = NSArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.registerNib()
        showLoadingHUD()
        priceListViewModel.getPriceList { [weak self] (isSuccess, message) in
            
            guard let strongSelf = self else{return}
            strongSelf.dismissLoadingHUD()
            if isSuccess {
                DispatchQueue.main.async {
                    strongSelf.categorySelectionCollectionView.reloadData()
                    //strongSelf.priceCollectionView.reloadData()
                    
                    let indexPath = IndexPath(row: 0, section: 0)

                    strongSelf.loadItemsInTable(indexPath)
                }
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
        }
    }

    
    
    @IBAction func notificationClick(_ sender: Any) {
        
        guard let navViewController = NotificationVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? NotificationVC
            else { return  }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    func setupUI() {
        
        self.showCategoryButton.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        self.showCategoryButton.layer.cornerRadius = 5
        self.showCategoryButton.layer.borderColor = UIColor.lightGray.cgColor
        self.showCategoryButton.layer.borderWidth = 1
    }
    
    
    @IBAction func showCategoryButtonClick(_ sender: Any) {
    
        
        if priceListViewModel.servicesArr.count > 0 {

            let tempArr = NSMutableArray.init(array:priceListViewModel.servicesArr)
        
            let alertController = UIAlertController(title: "Show correction suggestions", message: "", preferredStyle: UIAlertController.Style.actionSheet)
            self.present(alertController, animated: true, completion: nil)//Are you sure you want to logout?
            
            for buttonTitle in tempArr {
                if let titleStr = buttonTitle as? String {
                    let title = titleStr.replacingOccurrences(of: "_", with: " ")
                let btnAlwaysShow:UIAlertAction  = (UIAlertAction(title: title, style: .default, handler: {[weak self] action in
                    
                    guard let strongSelf = self else{return}
                    if let titleStr = action.title{
                        strongSelf.selectedService = titleStr
                    }
                    strongSelf.showCategoryButton.setTitle(strongSelf.selectedService, for: .normal)
                    
                    strongSelf.categorySelectionCollectionView.reloadData()
                    strongSelf.priceCollectionView.reloadData()
                    }))
                    alertController.addAction(btnAlwaysShow)
                }
            }
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                alertController .dismiss(animated: true, completion: nil)
            }))
            
            
            
            
            /*guard let title = priceListViewModel.servicesArr[0]  else{return nil}
            
            let actionSheet = UIActionSheet(title: "Please select service", delegate: self, cancelButtonTitle:nil, destructiveButtonTitle: nil, otherButtonTitles:title)
            tempArr.removeObject(at: 0)

            for buttonTitle in tempArr {
                actionSheet.addButtonWithTitle(buttonTitle as? String)
            }

            actionSheet.showInView(self.view)*/
        
        }
    
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
//        self.selectedService = self.garmentServicesArray[buttonIndex] as! String
//
//        self.showCategoryButton.setTitle(self.selectedService, forState: UIControlState.Normal)
//
//        self.categorySelectionCollectionView.reloadData()
//        self.priceCollectionView.reloadData()
    }
    
    
    
    
    
    func registerNib() {
        
        categorySelectionCollectionView.register(PriceCategoryCollectionCell.nib, forCellWithReuseIdentifier: PriceCategoryCollectionCell.identifier)
        
        priceCollectionView.register(PriceCollectionCell.nib, forCellWithReuseIdentifier: PriceCollectionCell.identifier)
    }
    
    func loadItemsInTable(_ indexPath :IndexPath){
        guard let selCat = priceListViewModel.priceListItemsForIndexPath(indexPath as IndexPath) else{ return }
        
        self.selectedCategory = selCat
        if let selectedService = priceListViewModel.servicesArr[0] as? String{
                self.selectedService = selectedService
        }
        let title = self.selectedService.replacingOccurrences(of: "_", with: " ")
        self.showCategoryButton.setTitle(title, for: .normal)
        // self.priceCollectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.left, animated: true)
        self.priceCollectionView.reloadData()
    }
    
  
}

extension PriceListVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}

extension PriceListVC :UIActionSheetDelegate{
    
}

extension PriceListVC :UICollectionViewDelegate{
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 1 {
            
            loadItemsInTable(indexPath)
            self.categorySelectionCollectionView.reloadData()
        }
    }
    
}



extension PriceListVC : UICollectionViewDataSource {
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
        return priceListViewModel.numberOfPriceItemsList() //items
        }else{
            return 1//priceListViewModel.numberOfPriceList(self.selectedCategory)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {

           
            guard let cell = categorySelectionCollectionView.dequeueReusableCell(withReuseIdentifier: PriceCategoryCollectionCell.identifier, for: indexPath ) as? PriceCategoryCollectionCell else { return UICollectionViewCell() }
            
            cell.categoryLabel.text = priceListViewModel.priceListItemsForIndexPath(indexPath)
            let str = priceListViewModel.priceListItemsForIndexPath(indexPath)
//            cell.categoryLabel.text = str
            cell.categoryLabel.textColor = UIColor.white

            if str == self.selectedCategory {
                cell.selectedView.backgroundColor = PRIMARY_COLOUR
                cell.categoryLabel.textColor = UIColor.black
            }else{
                cell.categoryLabel.textColor = UIColor.gray
                cell.selectedView.backgroundColor = UIColor.clear
            }
            
            return cell
            
        }else{
            
            guard let cell = priceCollectionView.dequeueReusableCell(withReuseIdentifier: PriceCollectionCell.identifier, for: indexPath as IndexPath) as? PriceCollectionCell else { return UICollectionViewCell() }
          
            cell.selectedCat = self.selectedCategory
            cell.service = self.selectedService
            cell.priceListViewModel = priceListViewModel
            cell.registerCell()
            
            // cell.categoryLabel.text = priceListViewModel.priceListForIndexPath(self.selectedCategory, indexPath: indexPath)
          // cell.categoryLabel.text = priceListViewModel.priceListItemsForIndexPath(indexPath)
//
//            let dictKey:String = self.categoryArr[indexPath.row] as! String
//            let arr:NSArray = self.responseGarmentDict[dictKey] as! NSArray
//            cell.setupUI(arr, selectedService: self.selectedService)
            
            return cell
        }
        
    }
}


extension PriceListVC :UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize:CGSize!
        
        if collectionView.tag == 1 {
            cellSize = CGSize(width: 100, height: 50)
        }else{
            
            cellSize = CGSize(width: SCREEN_SIZE.width, height: SCREEN_SIZE.height-154)
            
        }
        
        return cellSize
    }
}



