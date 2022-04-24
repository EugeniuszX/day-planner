//
//  UIButton.swift
//  dayPlanner
//
//  Created by Evgeniy on 24/04/2022.
//

import UIKit


extension UIButton {
    func createSwitchButton() -> UIButton {
        let switchButton: UIButton = {
         let button = UIButton(type: .system)
            button.tintColor = .systemTeal
            button.setTitle("Open calendar", for: .normal)
            button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
            button.setTitleColor(.white, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setBackgroundImage(.pixel(ofColor: .systemBlue), for: .normal)
            button.layer.cornerRadius = 20
            button.layer.masksToBounds = true
            return button
        }()
        
        return switchButton
    }
}
