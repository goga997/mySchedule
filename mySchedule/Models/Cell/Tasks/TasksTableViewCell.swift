//
//  TasksTableViewCell.swift
//  mySchedule
//
//  Created by Grigore on 03.04.2023.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    //MARK: - LABELS... + Button(done)

    let taskName = UILabel(text: "", font: UIFont(name: "Avenir Next Demi Bold", size: 20), alignment: .left)
    let taskDescription = UILabel(text: "", font: UIFont(name: "Avenir Next", size: 14), alignment: .left)
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.tintColor = .black
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - INITIALISATORS..
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setConstraints()
        taskDescription.numberOfLines = 0
        self.selectionStyle = .none
        
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doneButtonTapped() {
        guard let index = index else { return }
        cellTaskDelegate?.doneButtonTapped(indexPath: index)
    }
    
    weak var cellTaskDelegate: PressDoneTaskButtonProtocol?
    var index: IndexPath?
    
    func configure(model: TaskModel) {
        
        taskName.text = model.taskName
        taskDescription.text = model.taskDescription
        backgroundColor = UIColor().colorFromHex("\(model.taskColor)")
        
        if model.taskReady {
            doneButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
        } else {
            doneButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        }
    }
    
    //MARK: - SETEZ CONSTRAINTS..
    
    func setConstraints() {
        
        self.contentView.addSubview(doneButton)
        NSLayoutConstraint.activate([
            doneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
            doneButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(taskName)
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            taskName.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor, constant: -5),
            taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskName.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(taskDescription)
        NSLayoutConstraint.activate([
            taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 5),
            taskDescription.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor, constant: -5),
            taskDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
}
