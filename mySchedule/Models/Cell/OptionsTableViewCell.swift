//
//  OptionsScheduleTableViewCell.swift
//  mySchedule
//
//  Created by Grigore on 03.04.2023.


import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    //MARK: - CREEZ DIN CE E CONSTITUIT CELL-UL MEU (VIEW + LABEL)
    
    let backGroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7309880853, green: 0.7926861644, blue: 1, alpha: 0.697873395)
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameCellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
       
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.onTintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        return repeatSwitch
    }()
    
    
    
//    let addImageContact: UIImageView = {
//       let imageView = UIImageView()
//        imageView.layer.cornerRadius = 10
//        imageView.image = UIImage(systemName: "person.fill.badge.plus")
//        imageView.isHidden = true
//
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    weak var switchRepeatDelegate: SwitchRepeatProtocol?
        
    
    
    //MARK: - INITIALISATORS..
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        repeatSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellScheduleConfigure(nameArray: [[String]], indexPath: IndexPath, hexColor: String) {
        nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
        repeatSwitch.isHidden = (indexPath.section == 4 ? false : true)
        
        let color = UIColor().colorFromHex(hexColor)
        backGroundViewCell.backgroundColor = (indexPath.section == 3 ? color : #colorLiteral(red: 0.9966295362, green: 0.8928209543, blue: 0.6836124063, alpha: 0.5026199019))
    }
    
    func cellTasksConfigure(nameArray: [String], indexPath: IndexPath, hexColor: String) {
        nameCellLabel.text = nameArray[indexPath.section]
        
        let color = UIColor().colorFromHex(hexColor)
        backGroundViewCell.backgroundColor = (indexPath.section == 3 ? color : #colorLiteral(red: 0.9966295362, green: 0.8928209543, blue: 0.6836124063, alpha: 0.5026199019))
    }
    
    func cellContactConfigure(nameArray: [String], indexPath: IndexPath, image: UIImage?) {
        nameCellLabel.text = nameArray[indexPath.section]
        
        if image == nil {
            indexPath.section == 4 ? backGroundViewCell.image = UIImage(systemName: "person.fill.badge.plus")?.withRenderingMode(.alwaysTemplate) : nil
            backGroundViewCell.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            indexPath.section == 4 ? backGroundViewCell.image = image : nil
            backGroundViewCell.contentMode = .scaleAspectFill
        }
      
    }
    
    //target pentru switch-ul meu
    
    @objc func switchChange(paramTarget: UISwitch) {
        switchRepeatDelegate?.SwitchRepeat(value: paramTarget.isOn)
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
        
        self.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: backGroundViewCell.leadingAnchor, constant: 15),
        ])
        
        self.contentView.addSubview(repeatSwitch)
        NSLayoutConstraint.activate([
            repeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            repeatSwitch.trailingAnchor.constraint(equalTo: backGroundViewCell.trailingAnchor, constant: -20),
        ])
        
//        self.contentView.addSubview(addImageContact)
//        NSLayoutConstraint.activate([
//            addImageContact.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
//            addImageContact.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
//            addImageContact.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
//            addImageContact.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
//        ])
    }
    
}
