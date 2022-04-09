//
//  PhotoCameraAlert.swift
//  dayPlanner
//
//  Created by Evgeniy on 09/04/2022.
//

import UIKit

extension UIViewController {
    func alertPhotoCamera(handlerSubmit: @escaping (UIImagePickerController.SourceType) -> Void) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            let camera = UIImagePickerController.SourceType.camera
            handlerSubmit(camera)
        }
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let photoLibrary = UIImagePickerController.SourceType.photoLibrary
            handlerSubmit(photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibrary)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
