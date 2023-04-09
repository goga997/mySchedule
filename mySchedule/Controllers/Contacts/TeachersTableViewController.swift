//
//  TeachersViewController.swift
//  mySchedule
//
//  Created by Grigore on 05.04.2023.
//

import UIKit
import RealmSwift

class TeachersTableViewController: UITableViewController {
    
    private let localRealm = try! Realm()
    private var contactsArray: Results<ContactModel>!
    private let teacherID = "teacherID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9321168065, green: 0.9681312442, blue: 0.8774852157, alpha: 1)

        title = "Professors"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: teacherID)
        
        contactsArray = localRealm.objects(ContactModel.self).filter("contactType = 'Teacher'")
    }
    
    private func setTeacher(teacher: String) {
        let scheduleOptions = self.navigationController?.viewControllers[1] as? ScheduleOptionsTableViewController
        scheduleOptions?.scheduleModel.scheduleTeacher = teacher
        scheduleOptions?.cellNameArray[2][0] = teacher
        scheduleOptions?.tableView.reloadRows(at: [[2,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teacherID, for: indexPath) as! ContactsTableViewCell
        
        let model = contactsArray[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactsArray[indexPath.row]
        setTeacher(teacher: model.contactName)
    }
}
