//
//  ShadowButton.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit


/**
 A button with nice rounded shadows.
 The shadow opacity increases when you touch the button.
 */
class ShadowButton: UIButton {
    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
            shadowLayer.fillColor = UIColor.clear.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: -2.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 2
            
//            layer.insertSublayer(shadowLayer, at: 0)
            layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addShadowOnTouch(from: self.layer.shadowOpacity, to: 0.8)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addShadowOnTouch(from: self.layer.shadowOpacity, to: 0.2)
        NotificationCenter.default.post(name: Constants.Notifications.StartButtonDidTouchUpInside, object: nil)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addShadowOnTouch(from: self.layer.shadowOpacity, to: 0.2)
    }
}
