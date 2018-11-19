//
//  AboutUsVC.swift
//  QDCCustomerApp
//
//  Created by Maahi on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {

     @IBOutlet var aboutUsViewModel:AboutUsViewModel!
    
    var informationArray : NSMutableArray = NSMutableArray()
    var responseDict = NSDictionary()
    let selectedIndexArr = NSMutableArray()
    @IBOutlet weak var informationTableView:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        informationTableView.register(AboutUsCell.nib, forCellReuseIdentifier: AboutUsCell.identifier)
        informationTableView.rowHeight = UITableView.automaticDimension
        informationTableView.estimatedRowHeight = 400
        
        
        
        showLoadingHUD()
        aboutUsViewModel.getAboutUsinformation { [weak self] (isSuccess, message) in
            
            
            guard let strongSelf = self else{return}
            strongSelf.dismissLoadingHUD()
            if isSuccess{
                DispatchQueue.main.async {
                    strongSelf.informationTableView.reloadData()
                }
                
            }else{
                showAlertMessage(vc: strongSelf, title: .Error, message: message)
            }
            
        }
        
        
        
    }
    
    
    
    func setupUI() {
        
//        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.height/2
//        self.updateButton.setTitleColor(COLOUR_ON_BUTTON, forState: UIControlState.Normal)
//        self.updateButton.backgroundColor = BUTTON_COLOUR
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AboutUsVC{
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}



extension AboutUsVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutUsViewModel.numberOfInformation()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutUsCell.identifier, for: indexPath)  as? AboutUsCell else { return UITableViewCell() }
        //cell.Offers = aboutUsViewModel.offersAt(for: indexPath)
        
        var headingstring:String = ""
        var contentString:String = ""
        
        switch indexPath.row {
        case 0:
            if let abthed = aboutUsViewModel.aboutUs?.AboutUsHeading{
                headingstring = abthed//(self.responseDict["AboutUsHeading"] as? String)!
            }
            if let abtcon = (aboutUsViewModel.aboutUs?.AboutUsContent){
                contentString = abtcon//(self.responseDict["AboutUsHeading"] as? String)!
            }
            
        case 1:
            if let abthed = aboutUsViewModel.aboutUs?.TermHeading{
                headingstring = abthed//(self.responseDict["AboutUsHeading"] as? String)!
            }
            if let abtcon = (aboutUsViewModel.aboutUs?.TermContent){
                contentString = abtcon//(self.responseDict["AboutUsHeading"] as? String)!
            }
            
        case 2:
            if let abthed = aboutUsViewModel.aboutUs?.PrivacyPolicyHeading{
                headingstring = abthed//(self.responseDict["AboutUsHeading"] as? String)!
            }
            if let abtcon = (aboutUsViewModel.aboutUs?.PrivacyPolicyContent){
                contentString = abtcon//(self.responseDict["AboutUsHeading"] as? String)!
            }
            
            
        case 3:
            if let abthed = aboutUsViewModel.aboutUs?.ReturnsHeading{
                headingstring = abthed//(self.responseDict["AboutUsHeading"] as? String)!
            }
            if let abtcon = (aboutUsViewModel.aboutUs?.ReturnsContent){
                contentString = abtcon//(self.responseDict["AboutUsHeading"] as? String)!
            }
            
        case 4:
            if let abthed = aboutUsViewModel.aboutUs?.RefundHeading{
                headingstring = abthed//(self.responseDict["AboutUsHeading"] as? String)!
            }
            if let abtcon = (aboutUsViewModel.aboutUs?.RefundContent){
                contentString = abtcon//(self.responseDict["AboutUsHeading"] as? String)!
            }
            
        default:
            headingstring = ""
            contentString = ""
        }
        
    
        cell.aboutTitleLabel?.text = headingstring

        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            let attrStr = try NSAttributedString(data: contentString.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: options, documentAttributes: nil)
            print(attrStr)
            cell.aboutDetailLabel?.attributedText = attrStr
            cell.aboutDetailLabel?.numberOfLines = 0
            
        }
        catch {
            print("error creating attributed string")
        }
    
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedIndexArr.contains(indexPath) {
            return UITableView.automaticDimension ;
        }else{
            return 48;
        }
    }
}

extension AboutUsVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        
        if selectedIndexArr.contains(indexPath) {
            
            selectedIndexArr.remove(indexPath)
        } else {
            selectedIndexArr.add(indexPath)
        }
        
        tableView.reloadData()
        
    }

}
