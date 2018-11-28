//
//  CustonButtons.swift
//  Fractal
//
//  Created by Sean on 4/11/18.
//  Copyright © 2018 derpydm. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var CornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = CornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
    }
}

extension UIView {
    func blinkstart() {
        UIView.animate(withDuration: 0.03, delay: 0.0, options: [.curveLinear], animations: {self.alpha = 0.2}, completion: nil)
    }
    func blinkend() {
        UIView.animate(withDuration: 0.05, delay: 0.0, options: [.curveLinear], animations: {self.alpha = 1.0}, completion: nil)
    }
}
