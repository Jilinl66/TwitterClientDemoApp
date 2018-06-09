//
//  UIView+Extension.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/9/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import UIKit

@IBDesignable public class DesignableUIView: UIView {}
@IBDesignable public class DesignableUIButton: UIButton {}

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

extension UIButton {
    // Natural corner radius
    func roundCorner() {
        layer.cornerRadius = min(bounds.width / 2, bounds.height / 2)
    }
    
    func enable() {
        alpha = 1
        isEnabled = true
    }
    
    func disable() {
        alpha = 0.25
        isEnabled = false
    }
}

extension UITextField {
    func hasText() -> Bool {
        return text != nil && !text!.isEmpty
    }
}
