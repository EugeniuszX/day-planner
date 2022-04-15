//
//  AlertOfUsers.swift
//  dayPlanner
//
//  Created by Evgeniy on 08/04/2022.
//

import UIKit

extension UIViewController {
    func alertOfUsers(label: UILabel, handlerSubmit: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let userFriendAction = UIAlertAction(title: "User", style: .default) { _ in
            label.text = "User"
            let typeUser = "User"
            handlerSubmit(typeUser)
        }
        
        let userStrangerAction = UIAlertAction(title: "Stranger", style: .default) { _ in
            label.text = "Stranger"
            let typeUser = "Stranger"
            handlerSubmit(typeUser)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        alertController.addAction(userFriendAction)
        alertController.addAction(userStrangerAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
