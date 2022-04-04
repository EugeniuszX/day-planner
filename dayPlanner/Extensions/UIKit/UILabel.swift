//
//  UILabel.swift
//  dayPlanner
//
//  Created by Evgeniy on 04/04/2022.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, alignment: NSTextAlignment) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = .black
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .red
    }
}
