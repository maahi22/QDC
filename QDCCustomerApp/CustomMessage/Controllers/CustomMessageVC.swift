//
//  CustomMessageVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 30/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class CustomMessageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension CustomMessageVC{
    
    static func getStoryboardInstance() -> UIViewController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()   else { return nil }
        return navViewController
    }
}
