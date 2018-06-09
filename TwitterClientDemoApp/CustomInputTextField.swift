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
    let inactiveStrokeColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.15)
    let activeStrokeColor = UIColor.white
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUnderlineLayer()
        layer.addSublayer(underlineLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initUnderlineLayer() {
        underlineLayer = CALayer()
        layer.borderColor = inactiveStrokeColor.cgColor
        layer.frame = CGRect(x: 0, y: self.frame.height - strokeWidth, width: self.frame.width, height: strokeWidth)
        layer.borderWidth = strokeWidth / 2
    }
}
