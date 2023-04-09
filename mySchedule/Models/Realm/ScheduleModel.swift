//
//  ScheduleModel.swift
//  mySchedule
//
//  Created by Grigore on 07.04.2023.
//
import Foundation
import RealmSwift

class ScheduleModel: Object {
    
    @Persisted var scheduleDate: Date?
    @Persisted var scheduleTime: Date?
    @Persisted var scheduleName: String = "Unknown"
    @Persisted var scheduleType: String = "Unknown"
    @Persisted var scheduleBuilding: String = "Unknown"
    @Persisted var scheduleAudience: String = "Unknown"
    @Persisted var scheduleTeacher: String = "Unknown"
    @Persisted var scheduleColor: String = "579F2B"
    @Persisted var scheduleRepeate: Bool = true
    @Persisted var scheduleWeekday: Int = 1
}
