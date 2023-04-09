//
//  AlertContactType.swift
//  mySchedule
//
//  Created by Grigore on 07.04.2023.
//

import UIKit

extension UIViewController {
    
    func alertFriendOrTeacher(label: UILabel, completionHandler: @escaping (String) -> Void) {
     
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let friend = UIAlertAction(title: "Friend", style: .default) { _ in
            label.text = "Friend"
            let typeContact = "Friend"
            
            completionHandler(typeContact)
        }
        
        let teacher = UIAlertAction(title: "Professor", style: .default) { _ in
            label.text = "Professor"
            let typeContact = "Professor"
            
            completionHandler(typeContact)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        
        
        alertController.addAction(friend)
        alertController.addAction(teacher)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
        
    }
    
}
