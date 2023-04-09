//
//  TasksColorTableViewController.swift
//  mySchedule
//
//  Created by Grigore on 05.04.2023.
//

import UIKit

class TasksColorTableViewController: UITableViewController {
    
    let idOptionsColorCell = "idOptionsColorCell"
    let idOptionsHeader = "idOptionsHeader"
    
    let headerNameArray = ["RED","ORANGE","YELLOW","GREEN","BLUE","DEEP BLUE","PURPLE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setez delegates
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9321168065, green: 0.9681312442, blue: 0.8774852157, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: "idOptionsColorCell")
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: "idOptionsHeader")
        
        
        title = "Color Tasks"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idOptionsColorCell", for: indexPath) as! ColorTableViewCell
        
        cell.cellConfigure(indexPath: indexPath)
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
        
        print("Tap Cell")
        
        switch indexPath.section {
        case 0: setColor(color: "EC3C1A")
        case 1:  setColor(color: "F07F5A")
        case 2:  setColor(color: "F7C758")
        case 3:  setColor(color: "95D26B")
        case 4:  setColor(color: "3DACF7")
        case 5:  setColor(color: "246590")
        case 6:  setColor(color: "8E5AF7")
        default:
            setColor(color: "FFFFFF")
        }
    }
 
    private func setColor(color: String) {
        let taskOptions = self.navigationController?.viewControllers[1] as? TasksOptionsTableViewController
        taskOptions?.hexColorCell = color
        taskOptions?.tableView.reloadRows(at: [[3,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
}
