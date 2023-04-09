//
//  ContactsTableViewCell.swift
//  mySchedule
//
//  Created by Grigore on 06.04.2023.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    let contactImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    let phoneImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone.fill")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let mailImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope.fill")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel = UILabel(text: "Maria Anton", font: UIFont(name: "Avenir Next Demi Bold", size: 20), alignment: .left)
    let phoneLabel = UILabel(text: "069101997", font: UIFont(name: "Avenir Next", size: 14), alignment: .left)
    let mailLabel = UILabel(text: "grigore.rgg@gmail.com", font: UIFont(name: "Avenir Next", size: 14), alignment: .left)
    
    override func layoutIfNeeded() {
        super.layoutSubviews()
        
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
        
    }
    
    //MARK: - INITIALISATORS..
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = #colorLiteral(red: 0.9966295362, green: 0.8928209543, blue: 0.6836124063, alpha: 0.5)
        self.selectionStyle = .none

        self.setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ContactModel) {
        nameLabel.text = model.contactName
        phoneLabel.text = model.contactPhone
        mailLabel.text = model.contactMail
        
        if let data = model.contactImages, let image = UIImage(data: data) {
            contactImageView.image = image
        } else {
            contactImageView.image = UIImage(systemName: "person.fill")
        }
        
        
    }
    
    //MARK: - SETEZ CONSTRAINTS..
    
    func setConstraints() {
        
        self.addSubview(contactImageView)
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            contactImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contactImageView.widthAnchor.constraint(equalToConstant: 70),
            contactImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel, mailImageView, mailLabel], axis: .horizontal, spacing: 3, distribution: .fillProportionally)
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 21)
        ])
            
    }
    
}
