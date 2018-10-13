//
//  DifficultyCell.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit


/**
 Cell representing a difficulty level.
 */
class DifficultyCell: UITableViewCell {
    
    @IBOutlet var wrapperView: UIView!
    @IBOutlet var levelImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        wrapperView.layer.cornerRadius = 8
    }
    
    /**
     Selecting the cell increases it's shadow opacity.
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.selectionStyle = .none
        if selected {
            self.wrapperView.addShadowOnTouch(from: self.layer.shadowOpacity, to: 0.8)
        } else {
            self.wrapperView.addShadowOnTouch(from: self.layer.shadowOpacity, to: 0.2, with: 0.1)
        }
        
        super.setSelected(selected, animated: animated)
    }
}
