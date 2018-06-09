//
//  CustomInputTextField.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/9/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import UIKit

class CustomInputTextField: UITextField {

    var underlineLayer: CALayer!
    
    let strokeWidth: CGFloat = 2.0
    let inactiveStrokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    let activeStrokeColor = UIColor.black
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUnderlineLayer()
        layer.addSublayer(underlineLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUnderlineLayer()
        layer.addSublayer(underlineLayer)
    }
    
    private func initUnderlineLayer() {
        underlineLayer = CALayer()
        underlineLayer.borderColor = inactiveStrokeColor.cgColor
        underlineLayer.frame = CGRect(x: 0, y: self.frame.height - strokeWidth, width: self.frame.width, height: strokeWidth)
        underlineLayer.borderWidth = strokeWidth / 2
    }
    
    func setActiveBorder() {
        underlineLayer.borderColor = activeStrokeColor.cgColor
    }
    
    func setInactiveBorder() {
        underlineLayer.borderColor = inactiveStrokeColor.cgColor
    }
}
