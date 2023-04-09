//
//  ScheduleViewController.swift
//  mySchedule
//
//  Created by Grigore on 31.03.2023.
//

import UIKit
import FSCalendar
import RealmSwift

class ScheduleViewController: UIViewController {
    
    
   private var calendarHideConstraint: NSLayoutConstraint!
    
    //creez calendarul:D
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    //creez buton pentru ca sa ascund calendarul
    private let showHideCalendarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Nexr Demi bold", size: 14)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private  let tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let localRealm = try! Realm()
    var scheduleArray: Results<ScheduleModel>!
    
    let idScheduleCell = "idScheduleCell" // identificatorul cell-ului
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = #colorLiteral(red: 0.9321168065, green: 0.9681312442, blue: 0.8774852157, alpha: 1)
        title = "Schedule"
       
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "idScheduleCell")
        
        setConstraints()
        swipeAction()
        scheduleOnDay(date: Date())
        
        showHideCalendarButton.addTarget(self, action: #selector(showHideTapped), for: .touchUpInside)
        
        //adaug buton-ul de adaugare:)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        navigationController?.tabBarController?.tabBar.scrollEdgeAppearance =  navigationController?.tabBarController?.tabBar.standardAppearance
        
    }
    
    @objc private func addButtonTapped() {
        let scheduleOption = ScheduleOptionsTableViewController()
        navigationController?.pushViewController(scheduleOption, animated: true)
    }
    
    @objc private func showHideTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideCalendarButton.setTitle("Close", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideCalendarButton.setTitle("Open", for: .normal)
        }
    }
    
    //MARK: - SwipeGestureRecognizer
    
    private func swipeAction() {
        let swipeUP = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUP.direction = .up
        calendar.addGestureRecognizer(swipeUP)
        
        let swipeDOWN = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDOWN.direction = .down
        calendar.addGestureRecognizer(swipeDOWN)
    }
    
    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up: showHideTapped()
        case .down: showHideTapped()
        default: break
        }
    }
    
    private func scheduleOnDay(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return }
        
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        let predicateRepeat = NSPredicate(format: "scheduleWeekday = \(weekday) AND scheduleRepeate = true")
        let predicateUnrepeat = NSPredicate(format: "scheduleRepeate = false AND scheduleDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        
        
        scheduleArray = localRealm.objects(ScheduleModel.self).filter(compound)
        tableView.reloadData()
    }
}

//MARK: - DELEGATES... for UITableView

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idScheduleCell", for: indexPath) as! ScheduleTableViewCell
        
        let model = scheduleArray[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
 
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = scheduleArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteScheduleModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: - DELEGATES... for Calendar

extension ScheduleViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHideConstraint.constant = bounds.height
        view.layoutIfNeeded() // e pentru animatie lenta
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        scheduleOnDay(date: date)
    }
}

//MARK: - SETEZ CONSTRAINT-URILE

extension ScheduleViewController {
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
