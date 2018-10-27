//
//  UIView+ShakeAnimation.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 30..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

public extension UIView {

    func shake(for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.15) {
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 4.0
            self.transform = CGAffineTransform(translationX: translation, y: 0)
        }

        propertyAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)

        propertyAnimator.addCompletion { (_) in
            self.layer.borderWidth = 0
        }

        propertyAnimator.startAnimation()
    }
}
