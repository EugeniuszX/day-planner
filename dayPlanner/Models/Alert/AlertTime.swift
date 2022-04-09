//
//  AlertTime.swift
//  dayPlanner
//
//  Created by Evgeniy on 06/04/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func alertTime(label: UILabel, completionHandler: @escaping (Date) -> Void) {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        
        alert.view.addSubview(datePicker)
        
        let actionOK = UIAlertAction(title: "OK", style: .default) {(action) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            
            let timeString = dateFormatter.string(from: datePicker.date)
            let timePlanner = datePicker.date
            completionHandler(timePlanner)
            
            label.text = timeString
            
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
       
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        
        present(alert, animated: true, completion: nil)
    }
}
