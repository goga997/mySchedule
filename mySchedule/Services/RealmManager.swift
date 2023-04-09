//
//  RealmManager.swift
//  mySchedule
//
//  Created by Grigore on 07.04.2023.
//

import RealmSwift
import Foundation

class RealmManager {
    // folosesc singleton
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    //schedule MOdel
    func saveScheduleModel(model: ScheduleModel ) {
//        print("Realm is located at:", localRealm.configuration.fileURL!)
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteScheduleModel(model: ScheduleModel ) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    //Task Model
    func saveTaskModel(model: TaskModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteTaskModel(model: TaskModel ) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updatereadyButtontaskModel(task: TaskModel, bool: Bool) {
        try! localRealm.write {
            task.taskReady = bool
        }
    }
    
    //Contact Model
    
    func saveContactModel(model: ContactModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteContactModel(model: ContactModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateContacModel(model: ContactModel, nameArray: [String], imageData: Data?) {
        try! localRealm.write {
            model.contactName = nameArray[0]
            model.contactPhone = nameArray[1]
            model.contactMail = nameArray[2]
            model.contactType = nameArray[3]
            model.contactImages = imageData
        }
    }

}
