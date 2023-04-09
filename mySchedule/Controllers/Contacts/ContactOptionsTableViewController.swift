//
//  ContactOptionsTableViewController.swift
//  mySchedule
//
//  Created by Grigore on 06.04.2023.
//

import UIKit

class ContactOptionsTableViewController: UITableViewController {
    
    let idOptionsContactCell = "idOptionsContactCell"
    let idOptionsHeader = "idOptionsHeader"
    
    let headerNameArray = ["NAME","PHONE","MAIL","CONTACT TYPE","CHOOSE IMAGE"]
    
    var cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
    
     var imageIsChanged = false
     var contactModel = ContactModel()
    
    var editModel: Bool = false
    
    var dataImage: Data?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Options Contacts"
        
        //setez delegates
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9321168065, green: 0.9681312442, blue: 0.8774852157, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "idOptionsContactCell")
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: "idOptionsHeader")
     
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
        
    }
    
    @objc private func saveButtonTapped(){
        if cellNameArray[0] == "Name" || cellNameArray[3] == "Type" {
            alertOk(title: "Error", message: "Fields: NAME, TYPE are required!")
        } else if editModel == false {
            setImageModel()
            setModel()
            
            RealmManager.shared.saveContactModel(model: contactModel)
            contactModel = ContactModel()
            
            var cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
            
            alertOk(title: "Saved", message: nil)
            tableView.reloadData()
            
        } else {
            setImageModel()
            RealmManager.shared.updateContacModel(model: contactModel, nameArray: cellNameArray, imageData: dataImage)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setModel() {
        contactModel.contactName = cellNameArray[0]
        contactModel.contactPhone = cellNameArray[1]
        contactModel.contactMail = cellNameArray[2]
        contactModel.contactType = cellNameArray[3]
        contactModel.contactImages = dataImage
    }
    
    @objc private func setImageModel() {
        
        if imageIsChanged {
            let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
            
            let image = cell.backGroundViewCell.image
            guard let imageData = image?.pngData() else { return }
            dataImage = imageData
            
            cell.backGroundViewCell.contentMode = .scaleAspectFit
            imageIsChanged = false
        } else {
            dataImage = nil
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idOptionsContactCell", for: indexPath) as! OptionsTableViewCell
        
        if editModel == false { //o redactez
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        } else if let data = contactModel.contactImages, let image = UIImage(data: data) {
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: image)
        } else {
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 4 ? 180 : 44
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "idOptionsHeader") as! HeaderOptionsTableViewCell
        
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0 : alertForCellName(label: cell.nameCellLabel, name: "Contact Name", placeHolder: "Enter contact name") { text in
//            self.contactModel.contactName = text
            self.cellNameArray[0] = text
        }
        case 1 : alertForCellName(label: cell.nameCellLabel, name: "Phone Number", placeHolder: "Enter phone number") { text in
//            self.contactModel.contactPhone = text
            self.cellNameArray[1] = text

        }
        case 2 : alertForCellName(label: cell.nameCellLabel, name: "Mail Contact", placeHolder: "Enter mail contact") { text in
//            self.contactModel.contactMail = text
            self.cellNameArray[2] = text

        }
        case 3 : alertFriendOrTeacher(label: cell.nameCellLabel) { (type) in
//            self.contactModel.contactType = type
            self.cellNameArray[3] = type

        }
        case 4: alertPhotoCamera { [self] source in
            self.chooseImagePicker(source: source)
        }

        default: print("ff")
        }
    }
    
   private func pushControllers(viewController: UIViewController) {
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ContactOptionsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // creez o metoda datorita careia ma voi adresa ori la camera ori la galerie
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    //aceasrta metoda transmite delegat-ului imaginea, redactata sau nu, respectiv aceasat imagine o voi atribui in imageView-u meu din cell
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
        
        cell.backGroundViewCell.image = info[.editedImage] as? UIImage
        cell.backGroundViewCell.contentMode = .scaleAspectFill
        cell.backGroundViewCell.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
    
}
