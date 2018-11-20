//
//  InterfaceController.swift
//  testApp Extension
//
//  Created by Levente Vig on 2018. 11. 18..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import WatchKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var counterLabel: WKInterfaceLabel!
    @IBOutlet var increaseButton: WKInterfaceButton!

    var counter = 0 {
        didSet {
            counterLabel.setText("\(counter)")
        }
    }

    var increaseValue = 1

    @IBAction func didTapIncreaseButton() {
        counter += increaseValue
    }

    @IBAction func didTapDecreaseButton() {
        if counter > 0 {
            counter -= increaseValue
        }
        if counter < 0 {
            counter = 0
        }
    }

    @IBAction func didTapResetButton() {
        counter = 0
    }

    @IBAction func multiplySwitch(_ value: Bool) {
        if value {
            increaseValue = 10
        } else {
            increaseValue = 1
        }
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
