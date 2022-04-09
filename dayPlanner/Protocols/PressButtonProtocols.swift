//
//  PressButtonProtocols.swift
//  dayPlanner
//
//  Created by Evgeniy on 04/04/2022.
//

import Foundation

protocol PressSubmitTaskButtonProtocol: AnyObject {
    func handlePressSubmit(indexPath: IndexPath)
}

protocol HandleSwitchProtocol: AnyObject {
    func handleSwitch(value: Bool)
        
}

