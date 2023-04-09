//
//  HeaderOptionsScheduleTableViewCell.swift
//  mySchedule
//
//  Created by Grigore on 03.04.2023.
//

import UIKit

class HeaderOptionsTableViewCell: UITableViewHeaderFooterView {
    
    //MARK: - creez label (titlul pentru cells mele)
    
    let headerLabel = UILabel(text: "", font: UIFont(name: "Avenir Next", size: 14), alignment: .left)
    
    

   
    
    //MARK: - INITIALISATORS..
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func headerConfigure(nameArray: [String], section: Int) {
        headerLabel.text = nameArray[section]
    }
    
    //MARK: - SETEZ CONSTRAINTS..
    
    func setConstraints() {
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
}
