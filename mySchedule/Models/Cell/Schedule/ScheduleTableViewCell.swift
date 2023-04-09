//
//  ScheduleTableViewCell.swift
//  mySchedule
//
//  Created by Grigore on 03.04.2023.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    //MARK: - LABELS...
    
//    let lessonName: UILabel = {
//        let label = UILabel()
//
//        label.text = "programming"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//
//        return label
//    }()
    
    
//    let teacherName: UILabel = {
//        let label = UILabel()
//
//        label.text = "boris borea borevich"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next Demi", size: 20)
//        label.textAlignment = .right
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//
//        return label
//    }()
    
//    let lessonTime: UILabel = {
//        let label = UILabel()
//
//        label.text = "08:00"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//
//        return label
//    }()
//
//    let typeLabel: UILabel = {
//        let label = UILabel()
//
//        label.text = "Tip:"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next", size: 14)
//        label.textAlignment = .right
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//
//        return label
//    }()
    
//    let lessonType: UILabel = {
//        let label = UILabel()
//
//        label.text = "Curs"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//
//        return label
//    }()
//
//    let buildingLabel: UILabel = {
//        let label = UILabel()
//
//        label.text = "Blocul:"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next", size: 14)
//        label.textAlignment = .right
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//
//        return label
//    }()
    
//    let lessonBuilding: UILabel = {
//        let label = UILabel()
//
//        label.text = "C"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//
//        return label
//    }()
    
//    let salaLabel: UILabel = {
//        let label = UILabel()
//
//        label.text = "Sala:"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next", size: 14)
//        label.textAlignment = .right
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//
//        return label
//    }()
//
//    let lessonSala: UILabel = {
//        let label = UILabel()
//
//        label.text = "24A"
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
//
//        return label
//    }()
    
    let lessonName = UILabel(text: "", font: UIFont(name: "Avenir Next", size: 20), alignment: .left)
    let teacherName = UILabel(text: "", font: UIFont(name: "Avenir Next", size: 20), alignment: .right)
    let lessonTime = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 20), alignment: .left)
    let typeLabel = UILabel(text: "Type", font: UIFont(name: "Avenir Next", size: 14), alignment: .right)
    let lessonType = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 20), alignment: .left)
    let buildingLabel = UILabel(text: "Building", font: UIFont(name: "Avenir Next", size: 14), alignment: .right)
    let lessonBuilding = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14), alignment: .left)
    let salaLabel = UILabel(text: "Audience", font: UIFont(name: "Avenir Next", size: 14), alignment: .right)
    let lessonSala = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 14), alignment: .left)
    
    //MARK: - INITIALISATORS..
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setConstraints()
        
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(model: ScheduleModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        lessonName.text = model.scheduleName
        teacherName.text = model.scheduleTeacher
        guard let time = model.scheduleTime else { return }
        lessonTime.text = dateFormatter.string(from: time)
        lessonType.text = model.scheduleType
        lessonBuilding.text = model.scheduleBuilding
        lessonSala.text = model.scheduleAudience
        backgroundColor = UIColor().colorFromHex("\(model.scheduleColor)")
    }
    
    //MARK: - SETEZ CONSTRAINTS..
    
    func setConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [lessonName, teacherName], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        
        self.addSubview(topStackView)
            NSLayoutConstraint.activate([
                topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
                topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
                topStackView.heightAnchor.constraint(equalToConstant: 25)
            ])
        
        self.addSubview(lessonTime)
        NSLayoutConstraint.activate([
            lessonTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            lessonTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            lessonTime.widthAnchor.constraint(equalToConstant: 100),
            lessonTime.heightAnchor.constraint(equalToConstant: 25)
            ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [typeLabel, lessonType, buildingLabel, lessonBuilding, salaLabel, lessonSala], axis: .horizontal, spacing: 5, distribution: .fillProportionally)
        
        self.addSubview(bottomStackView)
            NSLayoutConstraint.activate([
                bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                bottomStackView.leadingAnchor.constraint(equalTo: lessonTime.trailingAnchor, constant: 5),
                bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
                bottomStackView.heightAnchor.constraint(equalToConstant: 25)
            ])
    }
    
}
