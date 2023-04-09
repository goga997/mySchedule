//
//  ColorScheduleTableViewCell.swift
//  mySchedule
//
//  Created by Grigore on 05.04.2023.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    
    //MARK: - CREEZ DIN CE E CONSTITUIT CELL-UL MEU (VIEW)
    
    let backGroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9966295362, green: 0.8928209543, blue: 0.6836124063, alpha: 0.1462896527)
        view.layer.cornerRadius = 10
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - INITIALISATORS..
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfigure(indexPath: IndexPath) {
       
        switch indexPath.section {
        case 0: backGroundViewCell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case 1: backGroundViewCell.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        case 2: backGroundViewCell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        case 3: backGroundViewCell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        case 4: backGroundViewCell.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        case 5: backGroundViewCell.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        case 6: backGroundViewCell.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        default:
            backGroundViewCell.backgroundColor = .clear
        }
    }
    
    //MARK: - SETEZ CONSTRAINTS..
    
    func setConstraints() {
        self.addSubview(backGroundViewCell)
        NSLayoutConstraint.activate([
            backGroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backGroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backGroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backGroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
    }
}
