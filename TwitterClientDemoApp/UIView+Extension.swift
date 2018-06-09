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
    public var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

extension UIButton {
    // Natural corner radius
    public func roundCorner() {
        layer.cornerRadius = min(bounds.width / 2, bounds.height / 2)
    }
}
