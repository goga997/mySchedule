//
//  TaskModel.swift
//  mySchedule
//
//  Created by Grigore on 08.04.2023.
//

import Foundation
import RealmSwift

class TaskModel: Object {
    
    @Persisted var taskDate: Date?
    @Persisted var taskName: String = "Unknown"
    @Persisted var taskDescription: String = "Unknown"
    @Persisted var taskColor: String = "579F2B"
    @Persisted var taskReady: Bool = false
}
