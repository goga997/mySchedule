//
//  AlertForCellName.swift
//  mySchedule
//
//  Created by Grigore on 05.04.2023.
//

import UIKit

extension UIViewController {
    
    func alertForCellName(label: UILabel, name: String, placeHolder: String, completionHandler: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            let tfAlert = alert.textFields?.first
            guard let text = tfAlert?.text else { return }
            label.text = (text != "" ? text : label.text)
            completionHandler(text)
        }
        
        alert.addTextField { (tfAlert) in
            tfAlert.placeholder = placeHolder
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
