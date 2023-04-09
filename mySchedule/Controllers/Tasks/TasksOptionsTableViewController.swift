//
//  OptionsTasksTableView.swift
//  mySchedule
//
//  Created by Grigore on 05.04.2023.
//

import UIKit

class TasksOptionsTableViewController: UITableViewController {
    
    let idOptionsTasksCell = "idOptionsTasksCell"
    let idOptionsHeader = "idOptionsHeader"
    
    let headerNameArray = ["DATE","LESSON","TASK","COLOR"]
    
    let cellNameArray = ["Date", "Lesson", "Tasks", ""]
    
    var hexColorCell = "579F2B"
    
    private var taskModel = TaskModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Options Tasks"
        
        //setez delegates
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9321168065, green: 0.9681312442, blue: 0.8774852157, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "idOptionsTasksCell")
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: "idOptionsHeader")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func saveButtonTapped(){
        if taskModel.taskDate == nil || taskModel.taskName == "Unknown" {
            alertOk(title: "Error", message: "Fields: DATE, LESSON are required!")
        } else {
            taskModel.taskColor = hexColorCell
            RealmManager.shared.saveTaskModel(model: taskModel)
            
            taskModel = TaskModel()
            
            alertOk(title: "Saved", message: nil)
            hexColorCell = "579F2B"
            tableView.reloadData()
        }
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idOptionsTasksCell", for: indexPath) as! OptionsTableViewCell
        
        cell.cellTasksConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
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
        
        switch indexPath.section {
        case 0: alertDate(label: cell.nameCellLabel) { numberWeekDay, date in
            self.taskModel.taskDate = date
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Lesson Name", placeHolder: "Enter lesson name") { text in
            self.taskModel.taskName = text
        }
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Description Task", placeHolder: "Enter task description") { text in
            self.taskModel.taskDescription = text
        }
        case 3: pushControllers(viewController: TasksColorTableViewController())
            
        default: print("error")
        }
    }
    
    func pushControllers(viewController: UIViewController) {
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}
