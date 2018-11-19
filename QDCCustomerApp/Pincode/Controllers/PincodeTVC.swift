//
//  PiccodeTVC.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 21/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PincodeTVC: UITableViewController {
    
    @IBOutlet weak var pincodeTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkButton.setButtonTheme()
        self.navigationController?.isNavigationBarHidden = true
        let cornerRadius = imageView.frame.width/2
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        
        pincodeTextField.addDoneButtonToKeyboard(myAction:#selector(pincodeTextField.resignFirstResponder))
    }
    
    @IBAction func checkAvailabiltyPressed(_ sender: UIButton) {
        guard let pincode = pincodeTextField.text, pincode.count > 0 else{
            showAlertMessage(vc: self, title: .Message, message: "Enter a valid pincode.")
            return
        }
        QDCUserDefaults.setPinCode(pin: pincode)
        guard let navViewController = SelectLocalityVC.getStoryboardInstance(),
            let viewController = navViewController.topViewController as? SelectLocalityVC
        else{
            return
        }
        viewController.isBackButtonHidden = false
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PincodeTVC{
    
    static func getStoryboardInstance() -> UINavigationController?{
        let storyborad = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let navViewController = storyborad.instantiateInitialViewController()  as? UINavigationController else { return nil }
        return navViewController
    }
}
