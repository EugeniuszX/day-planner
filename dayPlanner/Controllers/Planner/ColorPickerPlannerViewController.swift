//
//  ColorPickerPlannerViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 07/04/2022.
//

import Foundation
import UIKit


class ColorPickerPlannerViewController: UIViewController, UIColorPickerViewControllerDelegate  {
    let colorPickerViewController: UIColorPickerViewController = {
        let colorPicker = UIColorPickerViewController()
        
        return colorPicker
    }()
    init(handleFinish: () -> Void) {
        super.init()
        colorPickerViewController.delegate = self
    }
   
}
