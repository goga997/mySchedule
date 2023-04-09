//
//  PhotoCameraAlert.swift
//  mySchedule
//
//  Created by Grigore on 07.04.2023.
//

import UIKit

extension UIViewController {
    
    func alertPhotoCamera(completionHandler: @escaping (UIImagePickerController.SourceType) -> Void) {
     
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            let camera = UIImagePickerController.SourceType.camera
            
            completionHandler(camera)
        }
        
        let photos = UIAlertAction(title: "Photos", style: .default) { _ in
            let photos = UIImagePickerController.SourceType.photoLibrary
            
            completionHandler(photos)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        
        
        alertController.addAction(camera)
        alertController.addAction(photos)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
        
    }
    
}
