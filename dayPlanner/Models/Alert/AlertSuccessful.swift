//
//  AlertSuccessful.swift
//  dayPlanner
//
//  Created by Evgeniy on 10/04/2022.
//

import UIKit

extension UIViewController {
    func alertSuccessful(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(actionOK)
     
        present(alert, animated: true, completion: nil)
    }
}
