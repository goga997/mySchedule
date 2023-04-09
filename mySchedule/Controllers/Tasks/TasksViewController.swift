//
//  TasksViewController.swift
//  mySchedule
//
//  Created by Grigore on 31.03.2023.
//

import UIKit
import FSCalendar
import RealmSwift

class TasksViewController: UIViewController {
    
    var calendarHideConstraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    let showHideCalendarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Nexr Demi bold", size: 14)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    let idTasksCell = "idTasksCell"
    
    let localRealm = try! Realm()
    var tasksArray: Results<TaskModel>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        view.backgroundColor = #colorLiteral(red: 0.9321168065, green: 0.9681312442, blue: 0.8774852157, alpha: 1)
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: "idTasksCell")
        
        setConstraints()
        swipeAction()
        setTaskOnDay(date: calendar.today!)
        
        showHideCalendarButton.addTarget(self, action: #selector(showHideTapped), for: .touchUpInside)
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc func addButtonTapped() {
        let tasksOptions = TasksOptionsTableViewController()
        navigationController?.pushViewController(tasksOptions, animated: true)
    }
    
    @objc func showHideTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideCalendarButton.setTitle("Close", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideCalendarButton.setTitle("Open", for: .normal)
        }
    }
    
    func setTaskOnDay(date: Date) {
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        tasksArray = localRealm.objects(TaskModel.self).filter("taskDate BETWEEN %@", [dateStart, dateEnd])
        tableView.reloadData()
    }
    
    //MARK: - SwipeGestureRecognizer
    
    func swipeAction() {
        let swipeUP = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUP.direction = .up
        calendar.addGestureRecognizer(swipeUP)
        
        let swipeDOWN = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDOWN.direction = .down
        calendar.addGestureRecognizer(swipeDOWN)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up: showHideTapped()
        case .down: showHideTapped()
        default: break
        }
    }
    
    
}

//MARK: - DELEGATES... for UITableView

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idTasksCell", for: indexPath) as! TasksTableViewCell
        
        cell.cellTaskDelegate = self
        cell.index = indexPath
        
        let model = tasksArray[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = tasksArray[indexPath.row]
        
        let deteleAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteTaskModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deteleAction])
    }
    
}

//unesc metoda mea din tasksTableViewCell cu TaskViewController
extension TasksViewController: PressDoneTaskButtonProtocol {
    func doneButtonTapped(indexPath: IndexPath) {
        
        let task = tasksArray[indexPath.row]
        RealmManager.shared.updatereadyButtontaskModel(task: task, bool: !task.taskReady)
        tableView.reloadData()
    }
    
        
}

//MARK: - DELEGATES for calendar...

extension TasksViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHideConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        setTaskOnDay(date: date)
    }
}

//constraints
extension TasksViewController {
    
    func setConstraints() {
        view.addSubview(calendar)
        
        calendarHideConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        calendar.addConstraint(calendarHideConstraint)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        view.addSubview(showHideCalendarButton)
        
        NSLayoutConstraint.activate([
            showHideCalendarButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideCalendarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            showHideCalendarButton.widthAnchor.constraint(equalToConstant: 100),
            showHideCalendarButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHideCalendarButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])

    }
}






