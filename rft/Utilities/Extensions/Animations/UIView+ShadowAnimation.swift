//
//  UIView+ShadowAnimation.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addShadowOnTouch(from minValue: Float, to maxValue: Float, with duration: Double = 0.2) {
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = minValue
        animation.toValue = maxValue
        animation.duration = duration
        self.layer.add(animation, forKey: animation.keyPath)
        self.layer.shadowOpacity = maxValue
    }
}
