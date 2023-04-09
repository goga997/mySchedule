//
//  OptionsScheduleViewController.swift
//  mySchedule
//
//  Created by Grigore on 03.04.2023.
//

import UIKit

class ScheduleOptionsTableViewController: UITableViewController {
    
    private let idOptionsScheduleCell = "idOptionsScheduleCell"
    private let idOptionsHeader = "idOptionsHeader"
    
    let headerNameArray = ["DATE AND TIME","LESSON","PROFESSOR","COLOR","PERIOD"]
    
    var cellNameArray = [["Date","Time"],
                         ["Name","Type", "Building", "Audience"],
                         ["Professor Name"],
                         [""],
                         ["Repeat every 7 days"]]
    
    var scheduleModel = ScheduleModel()
    
    var hexColorCell = "579F2B"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setez delegates
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9321168065, green: 0.9681312442, blue: 0.8774852157, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "idOptionsScheduleCell")
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: "idOptionsHeader")
        
        
        title = "Options Schedule"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func saveButtonTapped(){
        
        if scheduleModel.scheduleDate == nil || scheduleModel.scheduleTime == nil || scheduleModel.scheduleName == "Unknown" {
            alertOk(title: "Error", message: "Fields: DATE, TIME, NAME are required!")
        } else {
            scheduleModel.scheduleColor = hexColorCell
            RealmManager.shared.saveScheduleModel(model: scheduleModel)
            
            // ca sa nu cada app-ul meu cand voi face ceva schimbari dupa ce adaaug in baza de date un model.
            scheduleModel = ScheduleModel()
            
            alertOk(title: "Saved", message: nil)
            hexColorCell = "579F2B"
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 4
        case 2: return 1
        case 3: return 1
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idOptionsScheduleCell", for: indexPath) as! OptionsTableViewCell
        cell.cellScheduleConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        cell.switchRepeatDelegate = self 
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
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
        
        switch indexPath {
        case [0,0]: alertDate(label: cell.nameCellLabel) { (numberWeekDay, date) in
            self.scheduleModel.scheduleDate = date
            self.scheduleModel.scheduleWeekday = numberWeekDay
        }
        case [0,1]: alertTime(label: cell.nameCellLabel) { (time) in
            self.scheduleModel.scheduleTime = time
        }
            
        case [1,0]: alertForCellName(label: cell.nameCellLabel, name: "Lesson Name", placeHolder: "Enter lesson name") { text in
            self.scheduleModel.scheduleName = text
        }
        case [1,1]: alertForCellName(label: cell.nameCellLabel, name: "Lesson Type", placeHolder: "Enter type of the lesson") { text in
            self.scheduleModel.scheduleType = text
        }
        case [1,2]: alertForCellName(label: cell.nameCellLabel, name: "Building Number", placeHolder: "Enter building number") { text in
            self.scheduleModel.scheduleBuilding = text
        }
        case [1,3]: alertForCellName(label: cell.nameCellLabel, name: "Audience", placeHolder: "What is your audience") { text in
            self.scheduleModel.scheduleAudience = text
        }
            
        case [2,0]: pushControllers(viewController: TeachersTableViewController())
            
        case [3,0]: pushControllers(viewController: ScheduleColorViewController())
                
        default: print("error")
        }
    }
    
    func pushControllers(viewController: UIViewController) {
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension ScheduleOptionsTableViewController: SwitchRepeatProtocol {
    func SwitchRepeat(value: Bool) {
        scheduleModel.scheduleRepeate = value
    }
}
