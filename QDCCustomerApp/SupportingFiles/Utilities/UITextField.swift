//
//  UITextField.swift
//  I-Helper
//
//  Created by Maxtra Technologies P LTD on 12/08/17.
//  Copyright © 2017 Maxtra Technologies P LTD. All rights reserved.
//

import UIKit


extension UITextField{
    
    func addDoneButtonToKeyboard(myAction:Selector?){
        /*guard let customFont = UIFont(name: "Geometria-Medium", size: UIFont.labelFontSize) else {
         fatalError("""
         Failed to load the "Geometria-Bold" font.
         Make sure the font file is included in the project and the font name is spelled correctly.
         """
         )
         }
         
         self.font = UIFontMetrics.default.scaledFont(for: customFont)
         self.adjustsFontForContentSizeCategory = true*/
        self.alpha = 0.8
        self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.textColor = .black
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    
}


@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return
            bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 15))
        
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return
            bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 15))
        
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 15))
            
    }
    
    @IBInspectable var leftPadding: CGFloat = 10
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
}
