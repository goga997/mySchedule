//
//  ViewController.swift
//  mySchedule
//
//  Created by Grigore on 31.03.2023.
//

import UIKit
import RealmSwift

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTapBar()
    }
    
    func setupTapBar() {
        //Exista soft "SFsymbol" de la apple
        let scheduleVC = createNavController(vc: ScheduleViewController(), itemName: "Schedule", itemImage: "calendar.badge.clock")
        let tasksVC = createNavController(vc: TasksViewController(), itemName: "Tasks", itemImage: "text.badge.checkmark")
        let contactsVC = createNavController(vc: ContactsViewController(), itemName: "Contacts", itemImage: "rectangle.stack.person.crop")
        
        viewControllers = [scheduleVC, tasksVC, contactsVC]
    }
    
    func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController{
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        
//        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        return navController
    }
    
}

